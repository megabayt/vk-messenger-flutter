import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  static const PAGE_COUNT = '20';
  final VKService _vkService = locator<VKService>();

  ConversationsBloc() : super(ConversationsData());

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is ConversationsFetch) {
      yield* _mapConversationsFetchToState();
    }
    if (event is ConversationsFetchMore) {
      yield* _mapConversationsFetchMoreToState();
    }
    if (event is ConversationsChangeLastMessage) {
      yield* _mapConversationsChangeLastMessageToState(event);
    }
  }

  Stream<ConversationsState> _mapConversationsFetchToState() async* {
    if ((state is ConversationsError)) {
      yield ConversationsData();
    }
    if ((state as ConversationsData).isFetching) {
      return;
    }

    try {
      yield (state as ConversationsData).copyWith(isFetching: true);
      final result = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': '0',
      });
      yield (state as ConversationsData).copyWith(
        items: result?.response?.items ?? [],
        count: result?.response?.count ?? 0,
        isFetching: false,
      );
    } catch (e) {
      yield ConversationsError(message: e.toString());
    }
  }

  Stream<ConversationsState> _mapConversationsFetchMoreToState() async* {
    if ((state is ConversationsError)) {
      yield ConversationsData();
    }
    final currentState = state as ConversationsData;

    if (currentState.isFetching ||
        currentState.items.length >= currentState.count) {
      return;
    }

    if (currentState.items.length == 0) {
      yield* _mapConversationsFetchToState();
      return;
    }

    yield (state as ConversationsData).copyWith(isFetching: true);

    try {
      final data = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': currentState.items.length.toString(),
      });

      yield (state as ConversationsData).copyWith(
        count: data?.response?.count ?? 0,
        items: currentState.items + (data?.response?.items ?? []),
        isFetching: false,
      );
    } catch (e) {
      yield ConversationsError(message: e.toString());
    }
  }

  Stream<ConversationsState> _mapConversationsChangeLastMessageToState(
      ConversationsChangeLastMessage event) async* {
    final count = (state as ConversationsData).count;
    var newItems = List<VkConversationItem>.from(
        (state as ConversationsData).items ?? List<VkConversationItem>());

    final index = newItems.indexWhere(
        (element) => element.conversation.peer.id == event.message.peerId);

    if (index != -1) {
      newItems[index] = newItems[index].copyWith(
        lastMessage: event.message,
      );

      yield (state as ConversationsData).copyWith(
        items: newItems,
        count: count + 1,
      );
    }
  }
}
