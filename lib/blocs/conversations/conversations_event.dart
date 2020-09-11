part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsEvent {}

class ConversationsFetch extends ConversationsEvent {}

class ConversationsFetchMore extends ConversationsEvent {}

class ConversationsChangeLastMessage extends ConversationsEvent {
  final Message message;

  ConversationsChangeLastMessage(this.message);
}

class ConversationsRetry extends ConversationsEvent {}
