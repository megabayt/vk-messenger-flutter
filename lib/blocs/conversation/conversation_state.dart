part of 'conversation_bloc.dart';

@immutable
@CopyWith()
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
}
