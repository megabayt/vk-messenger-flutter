part of 'conversation_bloc.dart';

@immutable
class ConversationState {
  final int peerId;
  final Map<int, VkConversationResponse> data;
  final bool isFetching;
  final String error;
  final ConversationEvent lastEvent;
  final bool showEmojiKeyboard;
  final List<int> selectedMessagesIds;

  int get currentCount {
    return data != null && data.containsKey(peerId)
        ? data[peerId]?.count
        : null;
  }

  VkConversationResponse get currentHistory {
    return data != null && data.containsKey(peerId) ? data[peerId] : null;
  }

  List<Message> get currentMessages {
    return currentHistory?.items;
  }

  List<Message> get selectedMessages {
    return currentMessages
        .where((message) =>
            selectedMessagesIds.indexWhere(
                (selectedMessage) => selectedMessage == message?.id) !=
            -1)
        .toList();
  }

  ConversationState({
    this.peerId,
    this.data,
    this.isFetching = false,
    this.error = '',
    this.lastEvent,
    this.showEmojiKeyboard = false,
    this.selectedMessagesIds = const [],
  });

  ConversationState copyWith({
    int peerId,
    Map<int, VkConversationResponse> data,
    bool isFetching,
    String error,
    ConversationEvent lastEvent,
    bool showEmojiKeyboard,
    List<int> selectedMessagesIds,
  }) =>
      ConversationState(
        peerId: peerId ?? this.peerId,
        data: data ?? this.data,
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        lastEvent: lastEvent ?? this.lastEvent,
        showEmojiKeyboard: showEmojiKeyboard ?? this.showEmojiKeyboard,
        selectedMessagesIds: selectedMessagesIds ?? this.selectedMessagesIds,
      );
}
