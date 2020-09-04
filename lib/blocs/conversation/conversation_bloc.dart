import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/models/message.dart';

import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';
import 'package:vk_messenger_flutter/screens/router.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  static const PAGE_COUNT = '20';
  final VKService _vkService = locator<VKService>();
  final ConversationsBloc _conversationsBloc;

  ConversationBloc(ConversationsBloc conversationsBloc)
      : _conversationsBloc = conversationsBloc,
        super(ConversationData());

  get _peerId {
    return (state as ConversationData).peerId;
  }

  @override
  Stream<ConversationState> mapEventToState(
    ConversationEvent event,
  ) async* {
    if (event is ConversationSetPeerId) {
      yield* _mapConversationSetPeerId(event);
    }
    if (event is ConversationFetch) {
      yield* _mapConversationFetchToState();
    }
    if (event is ConversationFetchMore) {
      yield* _mapConversationFetchMoreToState();
    }
    if (event is ConversationSendMessage) {
      yield* _mapConversationSendMessageToState(event);
    }
    if (event is ConversationToggleEmojiKeyboard) {
      yield* _mapToggleEmojiKeyboardToState();
    }
    if (event is ConversationSelectMessage) {
      yield* _mapConversationSelectMessageToState(event);
    }
    if (event is ConversationForwardMessage) {
      yield* _mapConversationForwardMessageToState();
    }
    if (event is ConversationRemoveMessage) {
      yield* _mapConversationRemoveMessageToState(event);
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
  }

  Stream<ConversationState> _mapConversationSetPeerId(
      ConversationSetPeerId event) async* {
    yield (state as ConversationData).copyWith(
      peerId: event.peerId,
      selectedMessages: [],
    );
    Router.sailor.navigate(ConversationScreen.routeUrl);
    this.add(ConversationFetch());
  }

  Stream<ConversationState> _mapConversationFetchToState() async* {
    if ((state is ConversationError)) {
      yield ConversationData();
    }
    if ((state as ConversationData).isFetching) {
      return;
    }

    try {
      yield (state as ConversationData).copyWith(isFetching: true);

      final result = await _vkService.getHistory(
          {'count': PAGE_COUNT, 'offset': '0', 'peer_id': _peerId.toString()});

      var newData = Map<int, VkConversationResponse>.from(
          (state as ConversationData).data ??
              Map<int, VkConversationResponse>());

      newData[_peerId] = result?.response ?? [];

      yield (state as ConversationData).copyWith(
        isFetching: false,
        data: newData,
      );
    } catch (e) {
      yield ConversationError(message: e.toString());
    }
  }

  Stream<ConversationState> _mapConversationFetchMoreToState() async* {
    if ((state is ConversationError)) {
      yield ConversationData();
    }
    final currentState = state as ConversationData;

    final itemsCount = currentState?.currentItems?.length ?? 0;
    final totalCount = currentState?.currentCount ?? 0;

    if (currentState.isFetching || itemsCount >= totalCount) {
      return;
    }

    if (itemsCount == 0) {
      yield* _mapConversationFetchToState();
      return;
    }

    yield (state as ConversationData).copyWith(isFetching: true);

    try {
      final data = await _vkService.getHistory({
        'count': PAGE_COUNT,
        'offset': itemsCount.toString(),
        'peer_id': _peerId.toString(),
      });

      final newData = Map<int, VkConversationResponse>.from(
          (state as ConversationData).data ??
              Map<int, VkConversationResponse>());

      newData[_peerId].items.addAll(data?.response?.items ?? []);

      yield (state as ConversationData).copyWith(
        data: newData,
        isFetching: false,
      );
    } catch (e) {
      yield ConversationError(message: e.toString());
    }
  }

  Stream<ConversationState> _mapConversationSendMessageToState(
      ConversationSendMessage event) async* {
    final fwdMessages =
        ((state as ConversationData).fwdMessages ?? []).join(',');
    if (event.message == '' && fwdMessages == '') {
      return;
    }
    final int32max = 1 << 32;
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      out: 1,
      text: event.message,
      peerId: event.peerId,
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
      messageId = await _vkService.sendMessage({
        'peer_id': event.peerId.toString(),
        'random_id': Random.secure().nextInt(int32max).toString(),
        'message': event.message,
        'forward_messages': fwdMessages,
      });
    } catch (e) {
      message = message.copyWith(
        isError: true,
      );
    }

    try {
      final messageQuery = await _vkService.getMessages({
        'message_ids': messageId.toString(),
      });

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
    yield (state as ConversationData).copyWith(
      fwdMessages: [],
      selectedMessages: [],
    );
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );
  }

  Stream<ConversationState> _appendOrRemoveMessage(
      int randomId, Message message) async* {
    var newData = Map<int, VkConversationResponse>.from(
        (state as ConversationData).data ?? Map<int, VkConversationResponse>());

    final index = newData[message.peerId]
        .items
        .indexWhere((element) => element.id == randomId);

    if (index != -1) {
      newData[message.peerId].items.removeAt(index);
    }

    if (message != null) {
      newData[message.peerId].items.insert(0, message);

      yield (state as ConversationData).copyWith(data: newData);
    }
  }

  Stream<ConversationState> _mapToggleEmojiKeyboardToState() async* {
    yield (state as ConversationData).copyWith(
      showEmojiKeyboard: !(state as ConversationData).showEmojiKeyboard,
    );
  }

  Stream<ConversationState> _mapConversationSelectMessageToState(
      ConversationSelectMessage event) async* {
    final selectedMessages =
        List<int>.from((state as ConversationData).selectedMessages ?? []);

    final index =
        selectedMessages.indexWhere((element) => element == event.messageId);

    if (index == -1) {
      yield (state as ConversationData).copyWith(
        selectedMessages: selectedMessages + [event.messageId],
      );
    } else {
      selectedMessages.removeAt(index);
      yield (state as ConversationData).copyWith(
        selectedMessages: selectedMessages,
      );
    }
  }

  Stream<ConversationState> _mapConversationForwardMessageToState() async* {
    yield (state as ConversationData).copyWith(
      selectedMessages: [],
      fwdMessages: (state as ConversationData).selectedMessages,
    );
  }

  Stream<ConversationState> _mapConversationRemoveMessageToState(
      ConversationRemoveMessage event) async* {}

  Stream<ConversationState> _mapConversationReplyMessageToState() async* {}

  Stream<ConversationState>
      _mapConversationMarkImportantMessageToState() async* {}

  Stream<ConversationState> _mapConversationEditMessageToState() async* {}
}
