import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/models/profile.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  static const PAGE_COUNT = '20';
  final VKService _vkService = locator<VKService>();

  FriendsBloc() : super(FriendsState());

  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
    if (event is FriendsFetch) {
      yield* _mapFriendsFetchToState();
    }
    if (event is FriendsFetchMore) {
      yield* _mapFriendsFetchMoreToState();
    }
  }

  Stream<FriendsState> _mapFriendsFetchToState() async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: null,
      );
      final result = await _vkService.getFriends({
        'user_id': _vkService.userId.toString(),
        'order': 'hints',
        'fields': 'domain, photo_50',
        'count': PAGE_COUNT,
        'offset': '0',
      });

      if (result.error != null) {
        // TODO: throw custom error
        throw Exception();
      }

      yield state.copyWith(
        items: result?.response?.items ?? [],
        count: result?.response?.count ?? 0,
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении списка друзей.',
        isFetching: false,
      );
    }
  }

  Stream<FriendsState> _mapFriendsFetchMoreToState() async* {
    final currentState = state;

    if (currentState.isFetching ||
        currentState.items.length >= currentState.count) {
      return;
    }

    if (currentState.items.length == 0) {
      yield* _mapFriendsFetchToState();
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: null,
    );

    try {
      final data = await _vkService.getFriends({
        'user_id': _vkService.userId.toString(),
        'order': 'hints',
        'fields': 'domain, photo_50',
        'count': PAGE_COUNT,
        'offset': currentState.items.length.toString(),
      });

      if (data.error != null) {
        // TODO: throw custom error
        throw Exception();
      }

      yield state.copyWith(
        count: data?.response?.count ?? 0,
        items: currentState.items + (data?.response?.items ?? []),
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении списка друзей.',
        isFetching: false,
      );
    }
  }
}
