import 'package:vk_messenger_flutter/vk_models/conversation.dart';
import 'package:vk_messenger_flutter/vk_models/message.dart';
import 'package:vk_messenger_flutter/vk_models/profile.dart';

class VkConversationResponse {
  VkConversationResponse({
    this.count,
    this.items,
    this.conversations,
    this.profiles,
    this.groups,
  });

  final int count;
  final List<VkMessage> items;
  final List<VkConversation> conversations;
  final List<VkProfile> profiles;
  final List<VkProfile> groups;

  factory VkConversationResponse.fromMap(Map<String, dynamic> json) =>
      VkConversationResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkMessage>.from(
                json["items"].map((x) => VkMessage.fromMap(x))),
        conversations: json["conversations"] == null
            ? null
            : List<VkConversation>.from(
                json["conversations"].map((x) => VkConversation.fromMap(x))),
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
