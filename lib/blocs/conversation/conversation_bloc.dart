import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/constants/math.dart';
import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/attachment_sticker.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/local_models/message_flag.dart';
import 'package:vk_messenger_flutter/local_models/sticker.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/vk_models/delete_messages_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_history_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_messages_params.dart';
import 'package:vk_messenger_flutter/vk_models/send_message_params.dart';

part 'conversation_bloc.g.dart';
part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  static const PAGE_COUNT = 20;
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

  Future<Message> _fetchMessage(int messageId) async {
    Message message;
    try {
      final messageQuery = await _vkService.getMessages(GetMessagesParams(
        messageIds: [messageId],
      ));

      if (messageQuery.error != null) {
        throw Exception(messageQuery.error?.errorMsg);
      }

      final messages = messageQuery?.response?.items ?? [];

      if (messages?.length != 0) {
        message = Message.fromVkMessage(messageQuery?.response?.items[0]);
      } else {
        throw Exception('no messages!');
      }
    } catch (_) {}
    return message;
  }

  void _appendOrRemoveMessage(int randomId, Message message) {
    final conversationsState = _conversationsBloc?.state;
    final newMessages = List<Message>.from(
        conversationsState?.conversations?.getMessagesById(_peerId) ?? []);

    final index = newMessages.indexWhere((element) => element.id == randomId);

    if (index != -1) {
      newMessages.removeAt(index);
    }

    if (message != null) {
      newMessages.insert(0, message);

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: _peerId,
            messages: newMessages,
          ),
        ),
      );
    }
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
      // TODO: Process event
      yield* _mapConversationReplyMessageToState();
    }
    if (event is ConversationMarkImportantMessage) {
      // TODO: Process event
      yield* _mapConversationMarkImportantMessageToState();
    }
    if (event is ConversationEditMessage) {
      yield* _mapConversationEditMessageToState();
    }
    if (event is ConversationPollAddMessage) {
      yield* _mapConversationPollAddMessageToState(event);
    }
    if (event is ConversationPollEditMessage) {
      yield* _mapConversationPollEditMessageToState(event);
    }
    if (event is ConversationPollProcessFlags) {
      yield* _mapConversationPollProcessFlagsToState(event);
    }
    if (event is ConversationPollDeleteMessage) {
      yield* _mapConversationPollDeleteMessageToState(event);
    }
    if (event is ConversationPollReadMessage) {
      yield* _mapConversationPollReadMessageToState(event);
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
      showEmojiKeyboard: false,
    );
    if (!event.fwdMode) {
      _attachmentsBloc.add(AttachmentsClearAttachments());
    }
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

      final result = await _vkService.getHistory(GetHistoryParams(
        count: PAGE_COUNT,
        offset: 0,
        peerId: _peerId,
      ));

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final vkMessages = result?.response?.items ?? [];
      final messages = vkMessages.map((x) => Message.fromVkMessage(x)).toList();
      final messagesCount = result?.response?.count ?? 0;

      yield state.copyWith(
        isFetching: false,
      );

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: _peerId,
            messages: messages,
            messagesCount: messagesCount,
          ),
        ),
      );

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
    final conversationsState = _conversationsBloc?.state;
    final oldMessages =
        conversationsState?.conversations?.getMessagesById(_peerId) ?? [];
    final oldMessagesCount = oldMessages.length;
    final totalCount =
        conversationsState?.conversations?.getMessagesCountById(_peerId) ?? 0;

    if (state.isFetching || oldMessagesCount >= totalCount) {
      return;
    }

    if (oldMessagesCount == 0) {
      yield* _mapConversationFetchToState(event);
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: '',
    );

    try {
      final result = await _vkService.getHistory(GetHistoryParams(
        count: PAGE_COUNT,
        offset: oldMessagesCount,
        peerId: _peerId,
      ));

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final vkMessages = result?.response?.items ?? [];
      final messages = vkMessages.map((x) => Message.fromVkMessage(x)).toList();
      final messagesCount = result?.response?.count ?? 0;

      yield state.copyWith(
        isFetching: false,
      );

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: _peerId,
            messages: oldMessages + messages,
            messagesCount: messagesCount,
          ),
        ),
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
    final fwdMessages = _attachmentsBloc.state.fwdMessages ?? [];

    final attachments = (_attachmentsBloc.state.attachments ?? [])
        .where((element) => element != null && !element.isFetching)
        .map((element) => element.path)
        .toList();

    final location = _attachmentsBloc.state.location;
    final locationEmpty = location.latitude == 0 && location.longitude == 0;

    final replyTo = _attachmentsBloc.state.replyTo == 0
        ? null
        : _attachmentsBloc.state.replyTo;

    if (event.message == '' &&
        fwdMessages.length == 0 &&
        attachments.length == 0 &&
        locationEmpty) {
      return;
    }
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      isOut: true,
      text: event.message,
      fromId: _vkService.userId,
      date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      isSent: false,
    );

    _appendOrRemoveMessage(randomId, message);

    int messageId;

    try {
      final result = await _vkService.sendMessage(SendMessageParams(
        peerId: state.peerId,
        randomId: Random.secure().nextInt(int32max),
        message: event.message,
        forwardMessages: fwdMessages,
        attachment: attachments,
        lat: location.latitude,
        long: location.longitude,
        replyTo: replyTo,
      ));
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

    _appendOrRemoveMessage(randomId, message);

    yield state.copyWith(
      selectedMessagesIds: [],
    );
    _attachmentsBloc.add(AttachmentsClearAttachments());
  }

  Stream<ConversationState> _mapConversationSendStickerToState(
      ConversationSendSticker event) async* {
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      isOut: true,
      fromId: _vkService.userId,
      date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      attachments: List<Attachment>()
        ..add(
          AttachmentSticker(
            title: 'Стикер',
            url: event.sticker.url,
          ),
        ),
      isSent: false,
    );

    _appendOrRemoveMessage(randomId, message);

    int messageId;

    try {
      final result = await _vkService.sendMessage(SendMessageParams(
        peerId: state.peerId,
        randomId: Random.secure().nextInt(int32max),
        stickerId: event.sticker.id,
      ));
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

    _appendOrRemoveMessage(randomId, message);
    yield state.copyWith(
      selectedMessagesIds: [],
    );
    _attachmentsBloc.add(AttachmentsClearAttachments());
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

      final result = await _vkService.deleteMessages(DeleteMessagesParams(
        messageIds: selectedMessagesIds,
        deleteForAll: deleteForAll,
      ));

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final conversationsState = _conversationsBloc?.state;
      final newMessages = List<Message>.from(
          conversationsState?.conversations?.getMessagesById(_peerId) ?? []);

      newMessages.removeWhere((message) =>
          selectedMessagesIds.indexWhere(
              (selectedMessage) => selectedMessage == message?.id) !=
          -1);
      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(id: _peerId, messages: newMessages),
        ),
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при удалении сообщения.',
        lastEvent: event,
        isFetching: false,
      );
    }
  }

  Stream<ConversationState> _mapConversationReplyMessageToState() async* {
    final selectedMessagesIds = List<int>.from(state.selectedMessagesIds ?? []);

    final messageId =
        selectedMessagesIds.length != 0 ? selectedMessagesIds[0] : null;

    if (messageId != null) {
      _attachmentsBloc.add(AttachmentsReplyTo(messageId));
      yield state.copyWith(selectedMessagesIds: []);
    }
  }

  Stream<ConversationState>
      _mapConversationMarkImportantMessageToState() async* {}

  Stream<ConversationState> _mapConversationEditMessageToState() async* {}

  Stream<ConversationState> _mapConversationPollAddMessageToState(
      ConversationPollAddMessage event) async* {
    final messageId = event.messageId;
    final peerId = event.peerId;

    final message = await _fetchMessage(messageId);

    final conversationsState = _conversationsBloc?.state;
    final conversation = conversationsState.conversations?.getById(peerId);

    if (conversation == null) {
      _conversationsBloc.add(ConversationsFetch());
      return;
    }

    List<Message> newMessages = conversation?.messages == null
        ? null
        : List<Message>.from(conversation?.messages ?? []);

    if (message != null) {
      newMessages.insert(0, message);

      newMessages = newMessages.uniq();

      final hasNewMessages =
          (conversation?.messages ?? []).length < newMessages.length;

      final unreadCount = conversation?.unreadCount ?? 0;
      final messagesCount = conversation?.messagesCount ?? 0;

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: peerId,
            messages: newMessages,
            unreadCount: hasNewMessages ? unreadCount + 1 : unreadCount,
            messagesCount: hasNewMessages ? messagesCount + 1 : messagesCount,
          ),
        ),
      );
    }
  }

  Stream<ConversationState> _mapConversationPollEditMessageToState(
      ConversationPollEditMessage event) async* {
    final messageId = event.messageId;
    final peerId = event.peerId;

    final message = await _fetchMessage(messageId);

    final conversationsState = _conversationsBloc?.state;
    final newMessages = List<Message>.from(
        conversationsState?.conversations?.getMessagesById(peerId) ?? []);

    final index = newMessages.indexWhere((element) => element.id == messageId);

    if (message != null && index != -1) {
      newMessages.removeAt(index);
      newMessages.insert(index, message);

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: peerId,
            messages: newMessages,
          ),
        ),
      );
    }
  }

  Stream<ConversationState> _mapConversationPollDeleteMessageToState(
      ConversationPollDeleteMessage event) async* {
    final messageId = event.messageId;
    final peerId = event.peerId;

    final conversationsState = _conversationsBloc?.state;
    final newMessages = List<Message>.from(
        conversationsState?.conversations?.getMessagesById(peerId) ?? []);

    final index = newMessages.indexWhere((element) => element.id == messageId);

    if (index != -1) {
      newMessages.removeAt(index);

      _conversationsBloc.add(
        ConversationsUpdateConversation(
          Conversation(
            id: peerId,
            messages: newMessages,
          ),
        ),
      );
    }
  }

  Stream<ConversationState> _mapConversationPollProcessFlagsToState(
      ConversationPollProcessFlags event) async* {
    final flags = event.mask?.getMessageFlags() ?? [];

    flags.forEach((flag) {
      switch (flag) {
        case MessageFlag.DELETE_FOR_ALL:
        case MessageFlag.DELETED:
          this.add(
              ConversationPollDeleteMessage(event.peerId, event.messageId));
      }
    });
  }

  Stream<ConversationState> _mapConversationPollReadMessageToState(
      ConversationPollReadMessage event) async* {
    final messageId = event.messageId;
    final peerId = event.peerId;

    final conversationsState = _conversationsBloc?.state;

    final conversation = conversationsState?.conversations?.getById(peerId);

    final newConversation = event.inRead
        ? conversation.copyWith(inRead: messageId)
        : conversation.copyWith(outRead: messageId);

    _conversationsBloc.add(ConversationsUpdateConversation(newConversation));
  }
}
