part of 'conversation_bloc.dart';

@immutable
class ConversationState {
  final int peerId;
  final bool isFetching;
  final String error;
  final ConversationEvent lastEvent;
  final bool showEmojiKeyboard;
  final List<int> selectedMessagesIds;

  ConversationState({
    this.peerId,
    this.isFetching = false,
    this.error = '',
    this.lastEvent,
    this.showEmojiKeyboard = false,
    this.selectedMessagesIds = const [],
  });

  ConversationState copyWith({
    int peerId,
    bool isFetching,
    String error,
    ConversationEvent lastEvent,
    bool showEmojiKeyboard,
    List<int> selectedMessagesIds,
  }) =>
      ConversationState(
        peerId: peerId ?? this.peerId,
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        lastEvent: lastEvent ?? this.lastEvent,
        showEmojiKeyboard: showEmojiKeyboard ?? this.showEmojiKeyboard,
        selectedMessagesIds: selectedMessagesIds ?? this.selectedMessagesIds,
      );
}
