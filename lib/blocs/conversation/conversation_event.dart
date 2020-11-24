part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent {}

class ConversationSetPeerId extends ConversationEvent {
  final int peerId;
  final bool fwdMode;

  ConversationSetPeerId(this.peerId, [this.fwdMode = false]);
}

class ConversationFetch extends ConversationEvent {}

class ConversationFetchMore extends ConversationEvent {}

class ConversationToggleEmojiKeyboard extends ConversationEvent {}

class ConversationSendMessage extends ConversationEvent {
  final String message;

  ConversationSendMessage({
    @required this.message,
  });
}

class ConversationSendSticker extends ConversationEvent {
  final Sticker sticker;

  ConversationSendSticker({
    @required this.sticker,
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

class ConversationDeleteMessage extends ConversationEvent {
  final bool removeForEveryone;

  ConversationDeleteMessage([this.removeForEveryone = false]);
}

class ConversationReplyMessage extends ConversationEvent {}

class ConversationMarkImportantMessage extends ConversationEvent {}

class ConversationEditMessage extends ConversationEvent {}

class ConversationPollAddMessage extends ConversationEvent {
  final int messageId;

  ConversationPollAddMessage(this.messageId);
}

class ConversationPollEditMessage extends ConversationEvent {
  final int messageId;

  ConversationPollEditMessage(this.messageId);
}

class ConversationRetry extends ConversationEvent {}
