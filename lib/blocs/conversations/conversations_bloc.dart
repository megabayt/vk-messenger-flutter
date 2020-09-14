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

  ConversationsBloc() : super(ConversationsState());

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is ConversationsFetch) {
      yield* _mapConversationsFetchToState(event);
    }
    if (event is ConversationsFetchMore) {
      yield* _mapConversationsFetchMoreToState(event);
    }
    if (event is ConversationsChangeLastMessage) {
      yield* _mapConversationsChangeLastMessageToState(event);
    }
    if (event is ConversationsRetry && state.lastEvent != null) {
      this.add(state.lastEvent);
    }
  }

  Stream<ConversationsState> _mapConversationsFetchToState(ConversationsEvent event) async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: '',
      );
      final result = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': '0',
      });

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      yield state.copyWith(
        items: result?.response?.items ?? [],
        count: result?.response?.count ?? 0,
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

  Stream<ConversationsState> _mapConversationsFetchMoreToState(ConversationsEvent event) async* {
    final currentState = state;

    if (currentState.isFetching ||
        currentState.items.length >= currentState.count) {
      return;
    }

    if (currentState.items.length == 0) {
      yield* _mapConversationsFetchToState(event);
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: '',
    );

    try {
      final data = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': currentState.items.length.toString(),
      });

      if (data.error != null) {
        throw Exception(data.error?.errorMsg);
      }

      yield state.copyWith(
        count: data?.response?.count ?? 0,
        items: currentState.items + (data?.response?.items ?? []),
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

  Stream<ConversationsState> _mapConversationsChangeLastMessageToState(
      ConversationsChangeLastMessage event) async* {
    final count = state.count;
    var newItems = List<VkConversationItem>.from(
        state.items ?? List<VkConversationItem>());

    final index = newItems.indexWhere(
        (element) => element.conversation.peer.id == event.message.peerId);

    if (index != -1) {
      newItems[index] = newItems[index].copyWith(
        lastMessage: event.message,
      );

      yield state.copyWith(
        items: newItems,
        count: count,
      );
    }
  }
}
