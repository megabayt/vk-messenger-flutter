import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/utils/enum_values.dart';

class Conversation {
  Conversation({
    this.id,
    this.type,
    this.localId,
    this.chatSettings,
    this.unreadCount,
    this.messages,
  });

  final int id;
  final PeerType type;
  final int localId;
  final ChatSettings chatSettings;
  final int unreadCount;
  final List<Message> messages;

  Conversation copyWith({
    int id,
    PeerType type,
    int localId,
    ChatSettings chatSettings,
    int unreadCount,
    List<Message> messages,
  }) {
    return Conversation(
      id: id ?? this.id,
      type: type ?? this.type,
      localId: localId ?? this.localId,
      chatSettings: chatSettings ?? this.chatSettings,
      unreadCount: unreadCount ?? this.unreadCount,
      messages: messages ?? this.messages,
    );
  }
}

class ChatSettings {
  ChatSettings({
    this.activeIds,
    this.title,
  });

  final List<int> activeIds;
  final String title;
}

enum PeerType { USER, GROUP, CHAT }

final peerTypeValues = EnumValues({
  "user": PeerType.USER,
  "group": PeerType.GROUP,
  "chat": PeerType.CHAT,
});
