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

class ConversationsPollEditMessage extends ConversationsEvent {
  final Message message;

  ConversationsPollEditMessage(this.message);
}

class ConversationsPollReadMessage extends ConversationsEvent {
  final int peerId;
  final int messageId;
  final bool inRead;

  ConversationsPollReadMessage(this.peerId, this.messageId, this.inRead);
}

class ConversationsRetry extends ConversationsEvent {}
