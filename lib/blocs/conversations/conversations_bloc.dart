import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/models/conversation.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  static const PAGE_COUNT = '20';
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

  List<Conversation> _getConversations(Map<String, dynamic> data) {
    final items = mapPath(data, ['response', 'items']) ?? [];

    return items.map((element) => Conversation.fromJson(element)).toList();
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
      final result = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': '0',
      });

      if (mapPath(result, ['error']) != null) {
        throw Exception(mapPath(result, ['error', 'errorMsg']));
      }

      _profilesBloc.add(ProfilesAppend(
        mapPath(result, ['response', 'profiles']) ?? [],
        mapPath(result, ['response', 'groups']) ?? [],
      ));

      yield state.copyWith(
        conversations: _getConversations(result),
        totalCount: mapPath(result, ['response', 'totalCount']) ?? 0,
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
    final totalCount = currentState?.totalCount ?? 0;

    if (currentState.isFetching || conversations.length >= totalCount) {
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
      final data = await _vkService.getConversations({
        'count': PAGE_COUNT,
        'offset': conversations.length.toString(),
      });

      if (mapPath(data, ['error']) != null) {
        throw Exception(mapPath(data, ['error', 'errorMsg']));
      }

      _profilesBloc.add(ProfilesAppend(
        mapPath(data, ['response', 'profiles']) ?? [],
        mapPath(data, ['response', 'groups']) ?? [],
      ));

      yield state.copyWith(
        totalCount: mapPath(data, ['response', 'totalCount']) ?? 0,
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
