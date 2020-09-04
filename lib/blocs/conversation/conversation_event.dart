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
