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

class ConversationAppendOrReplaceMessage extends ConversationEvent {
  final int randomId;
  final Message message;

  ConversationAppendOrReplaceMessage(this.randomId, this.message);
}
