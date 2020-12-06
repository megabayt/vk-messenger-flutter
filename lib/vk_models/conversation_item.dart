import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/vk_models/conversation.dart';
import 'package:vk_messenger_flutter/vk_models/message.dart';

part 'conversation_item.g.dart';

@CopyWith()
class VkConversationItem {
  VkConversationItem({
    this.conversation,
    this.lastMessage,
  });

  final VkConversation conversation;
  final VkMessage lastMessage;

  factory VkConversationItem.fromMap(Map<String, dynamic> json) =>
      VkConversationItem(
          conversation: json["conversation"] == null
              ? null
              : VkConversation.fromMap(json["conversation"]),
          lastMessage: json["last_message"] == null
              ? null
              : VkMessage.fromMap(json["last_message"]));
}
