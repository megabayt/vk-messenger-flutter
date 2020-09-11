part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent {}

class ConversationSetPeerId extends ConversationEvent {
  final int peerId;

  ConversationSetPeerId(this.peerId);
}

class ConversationFetch extends ConversationEvent {}

class ConversationFetchMore extends ConversationEvent {}

class ConversationToggleEmojiKeyboard extends ConversationEvent {}

class ConversationSendMessage extends ConversationEvent {
  final int peerId;
  final String message;

  ConversationSendMessage({
    @required this.peerId,
    @required this.message,
  });
}

class ConversationSelectMessage extends ConversationEvent {
  final int messageId;

  ConversationSelectMessage(this.messageId);
}

class ConversationUnSelectMessage extends ConversationEvent {
  final int messageId;

  ConversationUnSelectMessage(this.messageId);
}

class ConversationForwardMessage extends ConversationEvent {}

class ConversationDeleteMessage extends ConversationEvent {
  final bool removeForEveryone;

  ConversationDeleteMessage([this.removeForEveryone = false]);
}

class ConversationReplyMessage extends ConversationEvent {}

class ConversationMarkImportantMessage extends ConversationEvent {}

class ConversationEditMessage extends ConversationEvent {}
