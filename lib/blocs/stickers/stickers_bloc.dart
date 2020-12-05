import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/local_models/sticker_pack.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'stickers_event.dart';
part 'stickers_state.dart';

class StickersBloc extends Bloc<StickersEvent, StickersState> {
  final VKService _vkService = locator<VKService>();

  StickersBloc() : super(StickersState());

  @override
  Stream<StickersState> mapEventToState(
    StickersEvent event,
  ) async* {
    if (event is StickersFetch) {
      yield* _mapStickersFetchToState(event);
    }
  }

  Stream<StickersState> _mapStickersFetchToState(StickersEvent event) async* {
    if (state.isFetching) {
      return;
    }

    try {
      yield state.copyWith(
        isFetching: true,
        error: '',
      );
      final result = await _vkService.getStickers();

      if (result.error != null) {
        throw Exception(result.error?.errorMsg);
      }

      final items = (result?.response?.items ?? [])
      .map((element) => StickerPack.fromVkStoreProduct(element))
      .toList();

      yield state.copyWith(
        items: items,
        isFetching: false,
      );
    } catch (e) {
      yield state.copyWith(
        error: 'Произошла ошибка при получении стикеров.',
        isFetching: false,
      );
    }
  }
}
