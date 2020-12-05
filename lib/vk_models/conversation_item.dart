import 'package:vk_messenger_flutter/vk_models/conversation.dart';
import 'package:vk_messenger_flutter/vk_models/message.dart';

class VkConversationItem {
  VkConversationItem({
    this.conversation,
    this.lastMessage,
  });

  final VkConversation conversation;
  final VkMessage lastMessage;

  VkConversationItem copyWith({
    VkConversation conversation,
    VkMessage lastMessage,
  }) {
    return VkConversationItem(
      conversation: conversation ?? this.conversation,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  factory VkConversationItem.fromMap(Map<String, dynamic> json) =>
      VkConversationItem(
          conversation: json["conversation"] == null
              ? null
              : VkConversation.fromMap(json["conversation"]),
          lastMessage: json["last_message"] == null
              ? null
              : VkMessage.fromMap(json["last_message"]));
}
