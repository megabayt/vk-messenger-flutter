import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:map_path/map_path.dart';
import 'package:vk_messenger_flutter/vk_models/conversations_response.dart';
import 'package:vk_messenger_flutter/vk_models/get_conversations_params.dart';
import 'package:vk_messenger_flutter/vk_models/vk_response.dart';

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
}
