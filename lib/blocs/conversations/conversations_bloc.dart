import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/vk_models/conversations_response.dart';
import 'package:vk_messenger_flutter/vk_models/get_conversations_params.dart';
import 'package:vk_messenger_flutter/vk_models/mark_as_read.dart';
import 'package:vk_messenger_flutter/vk_models/vk_response.dart';

part 'conversations_bloc.g.dart';
part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  static const PAGE_COUNT = 20;
  final VKService _vkService = locator<VKService>();
  final ProfilesBloc _profilesBloc;

  ConversationsBloc(ProfilesBloc profilesBloc)
      : _profilesBloc = profilesBloc,
        super(ConversationsState());

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
    if (event is ConversationsResetUnread) {
      yield* _mapConversationsResetUnreadToState(event);
    }
    if (event is ConversationsUpdateConversation) {
      yield* _mapConversationsUpdateConversationToState(event);
    }
    if (event is ConversationsRetry && state.lastEvent != null) {
      this.add(state.lastEvent);
    }
  }

  List<Conversation> _getConversations(
      VkResponse<VkConversationsResponse> data) {
    final items = data?.response?.items ?? [];

    return List<Conversation>.from(
        items.map((element) => Conversation.fromVkConversation(element)));
  }

  Stream<ConversationsState> _mapConversationsFetchToState(
      ConversationsEvent event) async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: '',
      );
      final result = await _vkService.getConversations(GetConversationsParams(
        count: PAGE_COUNT,
        offset: 0,
      ));

      if (result?.error != null) {
        throw Exception(result?.error?.errorMsg);
      }

      _profilesBloc.add(ProfilesAppend(
        result?.response?.profiles ?? [],
        result?.response?.groups ?? [],
      ));

      yield state.copyWith(
        conversations: _getConversations(result),
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

  Stream<ConversationsState> _mapConversationsFetchMoreToState(
      ConversationsEvent event) async* {
    final currentState = state;

    final conversations = currentState?.conversations ?? [];
    final count = currentState?.count ?? 0;

    if (currentState.isFetching || conversations.length >= count) {
      return;
    }

    if (conversations.length == 0) {
      yield* _mapConversationsFetchToState(event);
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: '',
    );

    try {
      final data = await _vkService.getConversations(GetConversationsParams(
        count: PAGE_COUNT,
        offset: conversations.length,
      ));

      if (data?.error != null) {
        throw Exception(data?.error?.errorMsg);
      }

      _profilesBloc.add(ProfilesAppend(
        data?.response?.profiles ?? [],
        data?.response?.groups ?? [],
      ));

      yield state.copyWith(
        count: data?.response?.count ?? 0,
        conversations: conversations + _getConversations(data),
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

  Stream<ConversationsState> _mapConversationsUpdateConversationToState(
      ConversationsUpdateConversation event) async* {
    final newConversations = state.conversations.map((element) {
      if (element.id == event.conversation.id) {
        return element.copyWith(
          unreadCount: event.conversation.unreadCount,
          messages: event.conversation.messages,
          messagesCount: event.conversation.messagesCount,
        );
      }
      return element;
    }).toList();

    yield state.copyWith(
      conversations: newConversations,
    );
  }

  Stream<ConversationsState> _mapConversationsResetUnreadToState(
      ConversationsResetUnread event) async* {
    try {
      final index = state.getIndexById(event.peerId);

      if (index != -1) {
        final newConversations = List<Conversation>.from(state.conversations);

        newConversations[index] = newConversations[index].copyWith(
          unreadCount: 0,
        );

        await _vkService.markAsRead(MarkAsReadParams(
          peerId: event.peerId,
          startMessageId: newConversations[index].messages[0].id,
        ));

        yield state.copyWith(
          conversations: newConversations,
        );
      }
    } catch (error) {
      print(error);
    }
  }
}
