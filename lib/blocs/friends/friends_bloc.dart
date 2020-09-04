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

  FriendsBloc() : super(FriendsData());

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
    if ((state is FriendsError)) {
      yield FriendsData();
    }
    if ((state as FriendsData).isFetching) {
      return;
    }

    try {
      yield (state as FriendsData).copyWith(isFetching: true);
      final result = await _vkService.getFriends({
        'user_id': _vkService.userId.toString(),
        'order': 'hints',
        'fields': 'domain, photo_50',
        'count': PAGE_COUNT,
        'offset': '0',
      });
      yield (state as FriendsData).copyWith(
        items: result?.response?.items ?? [],
        count: result?.response?.count ?? 0,
        isFetching: false,
      );
    } catch (e) {
      yield FriendsError(message: e.toString());
    }
  }

  Stream<FriendsState> _mapFriendsFetchMoreToState() async* {
    if ((state is FriendsError)) {
      yield FriendsData();
    }
    final currentState = state as FriendsData;

    if (currentState.isFetching ||
        currentState.items.length >= currentState.count) {
      return;
    }

    if (currentState.items.length == 0) {
      yield* _mapFriendsFetchToState();
      return;
    }

    yield (state as FriendsData).copyWith(isFetching: true);

    try {
      final data = await _vkService.getFriends({
        'user_id': _vkService.userId.toString(),
        'order': 'hints',
        'fields': 'domain, photo_50',
        'count': PAGE_COUNT,
        'offset': currentState.items.length.toString(),
      });

      yield (state as FriendsData).copyWith(
        count: data?.response?.count ?? 0,
        items: currentState.items + (data?.response?.items ?? []),
        isFetching: false,
      );
    } catch (e) {
      yield FriendsError(message: e.toString());
    }
  }
}
