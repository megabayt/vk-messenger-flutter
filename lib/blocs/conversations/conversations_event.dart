part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsEvent {}

class ConversationsFetch extends ConversationsEvent {}

class ConversationsFetchMore extends ConversationsEvent {}

class ConversationsChangeLastMessage extends ConversationsEvent {
  final Message message;

  ConversationsChangeLastMessage(this.message);
}

class ConversationsResetUnread extends ConversationsEvent {
  final int peerId;

  ConversationsResetUnread(this.peerId);
}

class ConversationsRetry extends ConversationsEvent {}
