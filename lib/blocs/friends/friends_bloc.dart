import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/local_models/profile.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/vk_models/get_friends_params.dart';

part 'friends_bloc.g.dart';
part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  static const PAGE_COUNT = 20;
  final VKService _vkService = locator<VKService>();

  FriendsBloc() : super(FriendsState());

  @override
  Stream<FriendsState> mapEventToState(
    FriendsEvent event,
  ) async* {
    if (event is FriendsFetch) {
      yield* _mapFriendsFetchToState(event);
    }
    if (event is FriendsFetchMore) {
      yield* _mapFriendsFetchMoreToState(event);
    }
    if (event is FriendsRetry && state.lastEvent != null) {
      this.add(state.lastEvent);
    }
  }

  Stream<FriendsState> _mapFriendsFetchToState(FriendsEvent event) async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: '',
      );
      final result = await _vkService.getFriends(GetFriendsParams(
        userId: _vkService.userId,
        order: 'hints',
        fields: 'domain, photo_50',
        count: PAGE_COUNT,
        offset: 0,
      ));

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final items = (result?.response?.items ?? [])
          .map((element) => Profile.fromVkProfile(element))
          .toList();

      yield state.copyWith(
        items: items,
        count: result?.response?.count ?? 0,
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении списка друзей.',
        lastEvent: event,
        isFetching: false,
      );
    }
  }

  Stream<FriendsState> _mapFriendsFetchMoreToState(FriendsEvent event) async* {
    if (state.isFetching || state.items.length >= state.count) {
      return;
    }

    if (state.items.length == 0) {
      yield* _mapFriendsFetchToState(event);
      return;
    }

    yield state.copyWith(
      isFetching: true,
      error: '',
    );

    try {
      final result = await _vkService.getFriends(GetFriendsParams(
        userId: _vkService.userId,
        order: 'hints',
        fields: 'domain, photo_50',
        count: PAGE_COUNT,
        offset: state.items.length,
      ));

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final newItems = (result?.response?.items ?? [])
          .map((element) => Profile.fromVkProfile(element))
          .toList();

      yield state.copyWith(
        count: result?.response?.count ?? 0,
        items: state.items + newItems,
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении списка друзей.',
        lastEvent: event,
        isFetching: false,
      );
    }
  }
}
