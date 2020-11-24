import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/constants/math.dart';
import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/models/sticker.dart';

import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  static const PAGE_COUNT = '20';
  final VKService _vkService = locator<VKService>();
  final ConversationsBloc _conversationsBloc;
  final AttachmentsBloc _attachmentsBloc;

  ConversationBloc(
      ConversationsBloc conversationsBloc, AttachmentsBloc attachmentsBloc)
      : _conversationsBloc = conversationsBloc,
        _attachmentsBloc = attachmentsBloc,
        super(ConversationState());

  get _peerId {
    return state.peerId;
  }

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConversationSetPeerId) {
      yield* _mapConversationSetPeerId(event);
    }
    if (event is ConversationFetch) {
      yield* _mapConversationFetchToState(event);
    }
    if (event is ConversationFetchMore) {
      yield* _mapConversationFetchMoreToState(event);
    }
    if (event is ConversationSendMessage) {
      yield* _mapConversationSendMessageToState(event);
    }
    if (event is ConversationSendSticker) {
      yield* _mapConversationSendStickerToState(event);
    }
    if (event is ConversationToggleEmojiKeyboard) {
      yield* _mapToggleEmojiKeyboardToState();
    }
    if (event is ConversationSelectMessage) {
      yield* _mapConversationSelectMessageToState(event);
    }
    if (event is ConversationDeleteMessage) {
      yield* _mapConversationDeleteMessageToState(event);
    }
    if (event is ConversationReplyMessage) {
      yield* _mapConversationReplyMessageToState();
    }
    if (event is ConversationMarkImportantMessage) {
      yield* _mapConversationMarkImportantMessageToState();
    }
    if (event is ConversationEditMessage) {
      yield* _mapConversationEditMessageToState();
    }
    if (event is ConversationPollAddMessage) {
      yield* _mapConversationPollAddMessageToState(event);
    }
    if (event is ConversationRetry && state.lastEvent != null) {
      this.add(state.lastEvent);
    }
  }

  Stream<ConversationState> _mapConversationSetPeerId(
      ConversationSetPeerId event) async* {
    yield state.copyWith(
      peerId: event.peerId,
      selectedMessagesIds: [],
    );
    if (!event.fwdMode) {
      _attachmentsBloc.add(AttachmentsClearAttachments());
    }
    AppRouter.sailor.navigate(ConversationScreen.routeUrl);
    this.add(ConversationFetch());
  }

  Stream<ConversationState> _mapConversationFetchToState(
      ConversationEvent event) async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: '',
      );

      final result = await _vkService.getHistory(
          {'count': PAGE_COUNT, 'offset': '0', 'peer_id': _peerId.toString()});

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      var newData = Map<int, VkConversationResponse>.from(
          state.data ?? Map<int, VkConversationResponse>());

      newData[_peerId] = result?.response ?? [];

      yield state.copyWith(
        isFetching: false,
        data: newData,
      );

      // Mark all conversation messages as read
      await _vkService.markAsRead({
        'peer_id': _peerId.toString(),
        'mark_conversation_as_read': '1',
      });

      _conversationsBloc.add(ConversationsResetUnread(_peerId));
    } catch (e) {
      yield state.copyWith(
        isFetching: false,
        error: 'Произошла ошибка при получении списка сообщений.',
        lastEvent: event,
      );
    }
  }

  Stream<ConversationState> _mapConversationFetchMoreToState(
      ConversationEvent event) async* {
    final currentState = state;

    final itemsCount = currentState?.currentMessages?.length ?? 0;
    final totalCount = currentState?.currentCount ?? 0;

    if (currentState.isFetching || itemsCount >= totalCount) {
      return;
    }

    if (itemsCount == 0) {
      yield* _mapConversationFetchToState(event);
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: '',
    );

    try {
      final data = await _vkService.getHistory({
        'count': PAGE_COUNT,
        'offset': itemsCount.toString(),
        'peer_id': _peerId.toString(),
      });

      if (data.error != null) {
        throw Exception(data.error?.errorMsg);
      }

      final newData = Map<int, VkConversationResponse>.from(
          state.data ?? Map<int, VkConversationResponse>());

      newData[_peerId].items.addAll(data?.response?.items ?? []);

      yield state.copyWith(
        data: newData,
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении списка сообщений.',
        lastEvent: event,
        isFetching: false,
      );
    }
  }

  Stream<ConversationState> _mapConversationSendMessageToState(
      ConversationSendMessage event) async* {
    final fwdMessages = (_attachmentsBloc.state.fwdMessages ?? []).join(',');
    final attachments = (_attachmentsBloc.state.attachments ?? [])
        .where((element) => element != null && !element.isFetching)
        .map((element) => element.path)
        .join(',');
    final location = _attachmentsBloc.state.location;
    final locationEmpty = location.latitude == 0 && location.longitude == 0;

    if (event.message == '' &&
        fwdMessages == '' &&
        attachments == '' &&
        locationEmpty) {
      return;
    }
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      out: 1,
      text: event.message,
      peerId: state.peerId,
      fromId: _vkService.userId,
      date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      isSent: false,
    );

    yield* _appendOrRemoveMessage(randomId, message);
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );

    int messageId;

    try {
      final result = await _vkService.sendMessage({
        'peer_id': state.peerId.toString(),
        'random_id': Random.secure().nextInt(int32max).toString(),
        'message': event.message,
        'forward_messages': fwdMessages,
        'attachment': attachments,
        'lat': location.latitude.toString(),
        'long': location.longitude.toString(),
      });
      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }
      messageId = result.response;
    } catch (e) {
      message = message.copyWith(
        isError: true,
      );
    }

    try {
      final messageQuery = await _vkService.getMessages({
        'message_ids': messageId.toString(),
      });

      if (messageQuery.error != null) {
        throw Exception(messageQuery.error?.errorMsg);
      }

      final messages = messageQuery?.response?.items ?? [];

      if (messages?.length != 0) {
        message = messageQuery?.response?.items[0];
      } else {
        throw Exception('no messages!');
      }
    } catch (_) {
      message = message.copyWith(id: messageId);
    }

    yield* _appendOrRemoveMessage(randomId, message);
    yield state.copyWith(
      selectedMessagesIds: [],
    );
    _attachmentsBloc.add(AttachmentsClearAttachments());
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );
  }

  Stream<ConversationState> _mapConversationSendStickerToState(
      ConversationSendSticker event) async* {
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      out: 1,
      peerId: state.peerId,
      fromId: _vkService.userId,
      date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      attachments: List<Attachment>()
        ..add(
          Attachment(
            type: AttachmentType.STICKER,
            sticker: event.sticker,
          ),
        ),
      isSent: false,
    );

    yield* _appendOrRemoveMessage(randomId, message);
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );

    int messageId;

    try {
      final result = await _vkService.sendMessage({
        'peer_id': state.peerId.toString(),
        'random_id': Random.secure().nextInt(int32max).toString(),
        'sticker_id': event.sticker.stickerId.toString(),
      });
      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }
      messageId = result.response;
    } catch (e) {
      message = message.copyWith(
        isError: true,
      );
    }

    message = await _fetchMessage(messageId);

    yield* _appendOrRemoveMessage(randomId, message);
    yield state.copyWith(
      selectedMessagesIds: [],
    );
    _attachmentsBloc.add(AttachmentsClearAttachments());
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );
  }

  Stream<ConversationState> _appendOrRemoveMessage(
      int randomId, Message message) async* {
    var newData = Map<int, VkConversationResponse>.from(
        state.data ?? Map<int, VkConversationResponse>());

    final index = newData[message.peerId]
        .items
        .indexWhere((element) => element.id == randomId);

    if (index != -1) {
      newData[message.peerId].items.removeAt(index);
    }

    if (message != null) {
      newData[message.peerId].items.insert(0, message);

      yield state.copyWith(data: newData);
    }
  }

  Stream<ConversationState> _mapToggleEmojiKeyboardToState() async* {
    yield state.copyWith(
      showEmojiKeyboard: !state.showEmojiKeyboard,
    );
  }

  Stream<ConversationState> _mapConversationSelectMessageToState(
      ConversationSelectMessage event) async* {
    final selectedMessagesIds = List<int>.from(state.selectedMessagesIds ?? []);

    final index =
        selectedMessagesIds.indexWhere((element) => element == event.messageId);

    if (index == -1) {
      yield state.copyWith(
        selectedMessagesIds: selectedMessagesIds + [event.messageId],
      );
    } else {
      selectedMessagesIds.removeAt(index);
      yield state.copyWith(
        selectedMessagesIds: selectedMessagesIds,
      );
    }
  }

  Stream<ConversationState> _mapConversationDeleteMessageToState(
      ConversationDeleteMessage event) async* {
    try {
      final deleteForAll = event.removeForEveryone;
      final selectedMessagesIds =
          List<int>.from(state.selectedMessagesIds ?? []);
      final newData = Map<int, VkConversationResponse>.from(
          state.data ?? Map<int, VkConversationResponse>());
      final result = await _vkService.deleteMessages({
        'message_ids': selectedMessagesIds.join(','),
        'delete_for_all': deleteForAll ? '1' : '0',
      });

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      newData[_peerId].items.removeWhere((message) =>
          selectedMessagesIds.indexWhere(
              (selectedMessage) => selectedMessage == message?.id) !=
          -1);
      yield state.copyWith(
        selectedMessagesIds: [],
        data: newData,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при удалении сообщения.',
        lastEvent: event,
        isFetching: false,
      );
    }
  }

  Stream<ConversationState> _mapConversationReplyMessageToState() async* {}

  Stream<ConversationState>
      _mapConversationMarkImportantMessageToState() async* {}

  Stream<ConversationState> _mapConversationEditMessageToState() async* {}

  Stream<ConversationState> _mapConversationPollAddMessageToState(
      ConversationPollAddMessage event) async* {
    final message = await _fetchMessage(event?.messageId);

    if (message?.peerId == _peerId) {
      var newData = Map<int, VkConversationResponse>.from(
          state.data ?? Map<int, VkConversationResponse>());

      if (message != null &&
          newData != null &&
          newData.containsKey(message.peerId)) {
        newData[message.peerId].items.insert(0, message);

        yield state.copyWith(data: newData);
      }
    }

    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );
  }

  Future<Message> _fetchMessage(int messageId) async {
    Message message;
    try {
      final messageQuery = await _vkService.getMessages({
        'message_ids': messageId.toString(),
      });

      if (messageQuery.error != null) {
        throw Exception(messageQuery.error?.errorMsg);
      }

      final messages = messageQuery?.response?.items ?? [];

      if (messages?.length != 0) {
        message = messageQuery?.response?.items[0];
      } else {
        throw Exception('no messages!');
      }
    } catch (_) {
      message = message.copyWith(id: messageId);
    }
    return message;
  }
}
