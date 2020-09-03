import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

  ConversationBloc() : super(ConversationData());

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
    if (event is ConversationAppendOrReplaceMessage) {
      yield* _mapConversationAppendOrReplaceMessageToState(event);
    }
    if (event is ConversationToggleEmojiKeyboard) {
      yield* _mapToggleEmojiKeyboardToState();
    }
  }

  Stream<ConversationState> _mapConversationSetPeerId(
      ConversationSetPeerId event) async* {
    yield (state as ConversationData).copyWith(peerId: event.peerId);
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

  Stream<ConversationState> _mapConversationAppendOrReplaceMessageToState(
      ConversationAppendOrReplaceMessage event) async* {
    var newData = Map<int, VkConversationResponse>.from(
        (state as ConversationData).data ?? Map<int, VkConversationResponse>());

    final index = newData[event.message.peerId]
        .items
        .indexWhere((element) => element.id == event.randomId);

    if (index != -1) {
      newData[event.message.peerId].items.removeAt(index);
    }

    if (event.message != null) {
      newData[event.message.peerId].items.insert(0, event.message);

      yield (state as ConversationData).copyWith(
        data: newData,
      );
    }
  }

  Stream<ConversationState> _mapToggleEmojiKeyboardToState() async* {
    yield (state as ConversationData).copyWith(
      showEmojiKeyboard: !(state as ConversationData).showEmojiKeyboard,
    );
  }
}
