import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';

abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
  Future<void> logout();
  Future<VkConversationsResponseBody> getConversations(Map<String, String> params);
  Future<VkConversationResponseBody> getHistory(Map<String, String> params);
  Future<int> sendMessage(Map<String, String> params);
}
