import 'dart:convert';

import 'package:vk_messenger_flutter/models/peer.dart';

class Conversation {
  Conversation({
    this.peer,
    this.lastMessageId,
    this.inRead,
    this.outRead,
    this.isMarkedUnread,
    this.important,
    this.chatSettings,
    this.unreadCount,
  });

  final Peer peer;
  final int lastMessageId;
  final int inRead;
  final int outRead;
  final bool isMarkedUnread;
  final bool important;
  final ChatSettings chatSettings;
  final int unreadCount;

  Conversation copyWith({
    Peer peer,
    int lastMessageId,
    int inRead,
    int outRead,
    bool isMarkedUnread,
    bool important,
    ChatSettings chatSettings,
    int unreadCount,
  }) {
    return Conversation(
      peer: peer ?? this.peer,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      inRead: inRead ?? this.inRead,
      outRead: outRead ?? this.outRead,
      isMarkedUnread: isMarkedUnread ?? this.isMarkedUnread,
      important: important ?? this.important,
      chatSettings: chatSettings ?? this.chatSettings,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        peer: json["peer"] == null ? null : Peer.fromJson(json["peer"]),
        lastMessageId:
            json["last_message_id"] == null ? null : json["last_message_id"],
        inRead: json["in_read"] == null ? null : json["in_read"],
        outRead: json["out_read"] == null ? null : json["out_read"],
        isMarkedUnread:
            json["is_marked_unread"] == null ? null : json["is_marked_unread"],
        important: json["important"] == null ? null : json["important"],
        chatSettings: json["chat_settings"] == null
            ? null
            : ChatSettings.fromJson(json["chat_settings"]),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "peer": peer == null ? null : peer.toJson(),
        "last_message_id": lastMessageId == null ? null : lastMessageId,
        "in_read": inRead == null ? null : inRead,
        "out_read": outRead == null ? null : outRead,
        "is_marked_unread": isMarkedUnread == null ? null : isMarkedUnread,
        "important": important == null ? null : important,
        "chat_settings": chatSettings == null ? null : chatSettings.toJson(),
        "unread_count": unreadCount == null ? null : unreadCount,
      };
}

class ChatSettings {
  ChatSettings({
    this.activeIds,
    this.title,
  });

  final List<int> activeIds;
  final String title;

  factory ChatSettings.fromRawJson(String str) =>
      ChatSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatSettings.fromJson(Map<String, dynamic> json) => ChatSettings(
        activeIds: json["active_ids"] == null
            ? null
            : List<int>.from(json["active_ids"].map((x) => x)),
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "active_ids": activeIds == null
            ? null
            : List<dynamic>.from(activeIds.map((x) => x)),
        "title": title == null ? null : title,
      };
}
