part of 'conversations_bloc.dart';

@immutable
@CopyWith()
class ConversationsState {
  final List<Conversation> conversations;
  final int count;
  final bool isFetching;
  final String error;
  final ConversationsEvent lastEvent;

  ConversationsState({
    this.conversations = const [],
    this.count = 0,
    this.isFetching = false,
    this.error = '',
    this.lastEvent,
  });
}
