import 'package:vk_messenger_flutter/models/vk_audio_upload_server.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/models/vk_delete_messages.dart';
import 'package:vk_messenger_flutter/models/vk_friends.dart';
import 'package:vk_messenger_flutter/models/vk_messages.dart';
import 'package:vk_messenger_flutter/models/vk_photo_messages_upload_server.dart';
import 'package:vk_messenger_flutter/models/vk_save_audio.dart';
import 'package:vk_messenger_flutter/models/vk_save_messages_photo.dart';
import 'package:vk_messenger_flutter/models/vk_save_video.dart';
import 'package:vk_messenger_flutter/models/vk_send_message.dart';

abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
  Future<void> logout();
  Future<VkConversationsResponseBody> getConversations(
      Map<String, String> params);
  Future<VkConversationResponseBody> getHistory(Map<String, String> params);
  Future<VkMessagesResponseBody> getMessages(Map<String, String> params);
  Future<VkDeleteMessagesResponseBody> deleteMessages(
      Map<String, String> params);
  Future<VkFriendsResponseBody> getFriends(Map<String, String> params);
  Future<VkSendMessageResponseBody> sendMessage(Map<String, String> params);
  Future<VkPhotoMessagesUploadServerResponseBody> getPhotoMessagesUploadServer(
      Map<String, String> params);
  Future<VkSaveMessagesPhoto> saveMessagesPhoto(Map<String, String> params);
  Future<VkSaveVideoResponseBody> saveVideo(Map<String, String> params);
  Future<VkAudioUploadServerResponseBody> getAudioUploadServer();
  Future<VkSaveAudio> saveAudio(Map<String, String> params);
}
