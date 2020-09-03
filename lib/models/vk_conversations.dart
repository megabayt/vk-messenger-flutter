import 'dart:convert';

import 'package:vk_messenger_flutter/models/conversation.dart';
import 'package:vk_messenger_flutter/models/group.dart';
import 'package:vk_messenger_flutter/models/profile.dart';
import 'package:vk_messenger_flutter/models/message.dart';

class VkConversationsResponseBody {
  VkConversationsResponseBody({
    this.response,
  });

  final VkConversationsResponse response;

  factory VkConversationsResponseBody.fromRawJson(String str) =>
      VkConversationsResponseBody.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VkConversationsResponseBody.fromJson(Map<String, dynamic> json) =>
      VkConversationsResponseBody(
        response: json["response"] == null
            ? null
            : VkConversationsResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
      };
}

class VkConversationsResponse {
  VkConversationsResponse({
    this.count,
    this.items,
    this.unreadCount,
    this.profiles,
    this.groups,
  });

  final int count;
  final List<VkConversationItem> items;
  final int unreadCount;
  final List<Profile> profiles;
  final List<Group> groups;

  factory VkConversationsResponse.fromRawJson(String str) =>
      VkConversationsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VkConversationsResponse.fromJson(Map<String, dynamic> json) =>
      VkConversationsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkConversationItem>.from(
                json["items"].map((x) => VkConversationItem.fromJson(x))),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
        profiles: json["profiles"] == null
            ? null
            : List<Profile>.from(
                json["profiles"].map((x) => Profile.fromJson(x))),
        groups: json["groups"] == null
            ? null
            : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "unread_count": unreadCount == null ? null : unreadCount,
        "profiles": profiles == null
            ? null
            : List<dynamic>.from(profiles.map((x) => x.toJson())),
        "groups": groups == null
            ? null
            : List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class VkConversationItem {
  VkConversationItem({
    this.conversation,
    this.lastMessage,
  });

  final Conversation conversation;
  final Message lastMessage;

  VkConversationItem copyWith({
    Conversation conversation,
    Message lastMessage,
  }) {
    return VkConversationItem(
      conversation: conversation ?? this.conversation,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  factory VkConversationItem.fromRawJson(String str) =>
      VkConversationItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VkConversationItem.fromJson(Map<String, dynamic> json) =>
      VkConversationItem(
          conversation: json["conversation"] == null
              ? null
              : Conversation.fromJson(json["conversation"]),
          lastMessage: json["last_message"] == null
              ? null
              : Message.fromJson(json["last_message"]));

  Map<String, dynamic> toJson() => {
        "conversation": conversation == null ? null : conversation.toJson(),
        "last_message": lastMessage == null ? null : lastMessage.toJson(),
      };
}
