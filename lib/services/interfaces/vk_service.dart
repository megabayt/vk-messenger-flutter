import 'package:vk_messenger_flutter/vk_models/audio.dart';
import 'package:vk_messenger_flutter/vk_models/conversation_response.dart';
import 'package:vk_messenger_flutter/vk_models/conversations_response.dart';
import 'package:vk_messenger_flutter/vk_models/delete_messages_params.dart';
import 'package:vk_messenger_flutter/vk_models/friends_response.dart';
import 'package:vk_messenger_flutter/vk_models/get_conversations_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_doc_messages_upload_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_friends_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_history_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_long_poll_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_messages_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_photo_upload_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/long_poll_server.dart';
import 'package:vk_messenger_flutter/vk_models/mark_as_read.dart';
import 'package:vk_messenger_flutter/vk_models/messages_response.dart';
import 'package:vk_messenger_flutter/vk_models/photo.dart';
import 'package:vk_messenger_flutter/vk_models/poll_result.dart';
import 'package:vk_messenger_flutter/vk_models/save_audio_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_doc.dart';
import 'package:vk_messenger_flutter/vk_models/save_doc_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_messages_photo_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_video.dart';
import 'package:vk_messenger_flutter/vk_models/save_video_params.dart';
import 'package:vk_messenger_flutter/vk_models/send_message_params.dart';
import 'package:vk_messenger_flutter/vk_models/store_products_response.dart';
import 'package:vk_messenger_flutter/vk_models/upload_server.dart';
import 'package:vk_messenger_flutter/vk_models/vk_response.dart';

abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
  Future<void> logout();

  Future<VkResponse<VkConversationsResponse>> getConversations(
      GetConversationsParams params);

  Future<VkResponse<VkConversationResponse>> getHistory(
      GetHistoryParams params);

  Future<VkResponse<VkMessagesResponse>> getMessages(GetMessagesParams params);

  Future<VkResponse<VkFriendsResponse>> getFriends(GetFriendsParams params);

  Future<VkResponse<int>> sendMessage(SendMessageParams params);

  Future<VkResponse<Map<String, int>>> deleteMessages(
      DeleteMessagesParams params);

  Future<VkResponse<VkUploadServer>> getPhotoMessagesUploadServer(
      GetPhotoUploadServerParams params);

  Future<VkResponse<VkPhoto>> saveMessagesPhoto(SaveMessagesPhotoParams params);

  Future<VkResponse<VkSaveVideo>> saveVideo(SaveVideoParams params);

  Future<VkResponse<VkUploadServer>> getAudioUploadServer();

  Future<VkResponse<VkAudio>> saveAudio(SaveAudioParams params);

  Future<VkResponse<VkUploadServer>> getDocMessagesUploadServer(
      GetDocMessagesUploadServerParams params);

  Future<VkResponse<VkSaveDoc>> saveDoc(SaveDocParams params);

  Future<VkResponse<VkStoreProductsResponse>> getStickers();

  Future<VkResponse<int>> markAsRead(MarkAsReadParams params);

  Future<VkResponse<VkLongPollServer>> getLongPollServer(
      GetLongPollServerParams params);

  Future<VkPollResult> poll(String pollUrl);
}
