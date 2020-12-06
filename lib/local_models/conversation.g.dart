// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ConversationCopyWith on Conversation {
  Conversation copyWith({
    List<int> activeIds,
    int id,
    int inRead,
    int localId,
    List<Message> messages,
    int messagesCount,
    int outRead,
    String title,
    VkPeerType type,
    int unreadCount,
  }) {
    return Conversation(
      activeIds: activeIds ?? this.activeIds,
      id: id ?? this.id,
      inRead: inRead ?? this.inRead,
      localId: localId ?? this.localId,
      messages: messages ?? this.messages,
      messagesCount: messagesCount ?? this.messagesCount,
      outRead: outRead ?? this.outRead,
      title: title ?? this.title,
      type: type ?? this.type,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
