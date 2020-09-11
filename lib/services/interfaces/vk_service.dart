import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/models/vk_delete_messages.dart';
import 'package:vk_messenger_flutter/models/vk_friends.dart';
import 'package:vk_messenger_flutter/models/vk_messages.dart';
import 'package:vk_messenger_flutter/models/vk_send_message.dart';

abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
  Future<void> logout();
  Future<VkConversationsResponseBody> getConversations(Map<String, String> params);
  Future<VkConversationResponseBody> getHistory(Map<String, String> params);
  Future<VkMessagesResponseBody> getMessages(Map<String, String> params);
  Future<VkDeleteMessagesResponseBody> deleteMessages(Map<String, String> params);
  Future<VkFriendsResponseBody> getFriends(Map<String, String> params);
  Future<VkSendMessageResponseBody> sendMessage(Map<String, String> params);
}
