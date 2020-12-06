import 'package:vk_messenger_flutter/vk_models/conversation_item.dart';
import 'package:vk_messenger_flutter/vk_models/profile.dart';

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
  final List<VkProfile> profiles;
  final List<VkProfile> groups;

  factory VkConversationsResponse.fromMap(Map<String, dynamic> json) =>
      VkConversationsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkConversationItem>.from(
                json["items"].map((x) => VkConversationItem.fromMap(x))),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
        profiles: json["profiles"] == null
            ? null
            : List<VkProfile>.from(
                json["profiles"].map((x) => VkProfile.fromMap(x))),
        groups: json["groups"] == null
            ? null
            : List<VkProfile>.from(
                json["groups"].map((x) => VkProfile.fromMap(x))),
      );
}
