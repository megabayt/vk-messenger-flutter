import 'package:vk_messenger_flutter/vk_models/chat_settings.dart';
import 'package:vk_messenger_flutter/vk_models/peer.dart';

class VkConversation {
  VkConversation({
    this.peer,
    this.lastMessageId,
    this.inRead,
    this.outRead,
    this.isMarkedUnread,
    this.important,
    this.chatSettings,
    this.unreadCount,
  });

  final VkPeer peer;
  final int lastMessageId;
  final int inRead;
  final int outRead;
  final bool isMarkedUnread;
  final bool important;
  final VkChatSettings chatSettings;
  final int unreadCount;

  factory VkConversation.fromMap(Map<String, dynamic> json) => VkConversation(
        peer: json["peer"] == null ? null : VkPeer.fromMap(json["peer"]),
        lastMessageId:
            json["last_message_id"] == null ? null : json["last_message_id"],
        inRead: json["in_read"] == null ? null : json["in_read"],
        outRead: json["out_read"] == null ? null : json["out_read"],
        isMarkedUnread:
            json["is_marked_unread"] == null ? null : json["is_marked_unread"],
        important: json["important"] == null ? null : json["important"],
        chatSettings: json["chat_settings"] == null
            ? null
            : VkChatSettings.fromMap(json["chat_settings"]),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
      );
}
