// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ConversationStateCopyWith on ConversationState {
  ConversationState copyWith({
    String error,
    bool isFetching,
    ConversationEvent lastEvent,
    int peerId,
    List<int> selectedMessagesIds,
    bool showEmojiKeyboard,
  }) {
    return ConversationState(
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
      lastEvent: lastEvent ?? this.lastEvent,
      peerId: peerId ?? this.peerId,
      selectedMessagesIds: selectedMessagesIds ?? this.selectedMessagesIds,
      showEmojiKeyboard: showEmojiKeyboard ?? this.showEmojiKeyboard,
    );
  }
}
