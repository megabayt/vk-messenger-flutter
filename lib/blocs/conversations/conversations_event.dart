part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsEvent {}

class ConversationsFetch extends ConversationsEvent {}

class ConversationsFetchMore extends ConversationsEvent {}

class ConversationsUpdateConversation extends ConversationsEvent {
  final Conversation conversation;

  ConversationsUpdateConversation(this.conversation);
}

class ConversationsResetUnread extends ConversationsEvent {
  final int peerId;

  ConversationsResetUnread(this.peerId);
}

class ConversationsRetry extends ConversationsEvent {}
