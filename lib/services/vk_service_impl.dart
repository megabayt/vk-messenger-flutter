import 'dart:convert';

import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:http/http.dart' as http;

import 'package:vk_messenger_flutter/constants/api.dart' as api;
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/errors.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
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
import 'package:vk_messenger_flutter/vk_models/register_device_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_audio_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_doc.dart';
import 'package:vk_messenger_flutter/vk_models/save_doc_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_messages_photo_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_video.dart';
import 'package:vk_messenger_flutter/vk_models/save_video_params.dart';
import 'package:vk_messenger_flutter/vk_models/send_message_params.dart';
import 'package:vk_messenger_flutter/vk_models/store_products_response.dart';
import 'package:vk_messenger_flutter/vk_models/unregister_device_params.dart';
import 'package:vk_messenger_flutter/vk_models/upload_server.dart';
import 'package:vk_messenger_flutter/vk_models/vk_error.dart';
import 'package:vk_messenger_flutter/vk_models/vk_response.dart';

class VkServiceImpl implements VKService {
  final _instance = VKLogin(); // Your application ID
  VKAccessToken _tokenObject;

  get token {
    return _tokenObject?.token;
  }

  get userId {
    return int.parse(_tokenObject.userId);
  }

  Future<void> login() async {
    if (!_instance.isInitialized) {
      await _instance.initSdk(api.appId);
    }
    final isLoggedIn = await _instance.isLoggedIn;
    if (isLoggedIn) {
      _tokenObject = await _instance.accessToken;
      return;
    }
    final loginResult = await _instance.logIn(scope: [
      VKScope.friends,
      VKScope.messages,
      VKScope.photos,
      VKScope.video,
      VKScope.audio,
      VKScope.docs,
      VKScope.offline,
    ]);
    if (loginResult.isValue) {
      final loginData = loginResult.asValue.value;
      if (loginData.isCanceled) {
        // Пользователь отменил авторизацию, пробуем снова
        throw VKServiceError('User cancelled login request');
      } else {
        // Вход выполнен
        _tokenObject = loginData.accessToken;
      }
    } else {
      // Словили ошибку авторизации, пробуем снова
      throw VKServiceError(loginResult.asError.error);
    }
  }

  Future<void> logout() {
    return _instance.logOut();
  }

  Future<Map<String, dynamic>> _invokeMethod(String method,
      [Map<String, String> params]) async {
    var url = '${api.BASE_URL}$method?access_token=$token&v=${api.VERSION}';

    if (params != null) {
      url += serialize(params);
    }

    final response = await http.get(url);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    return responseBody;
  }

  Future<VkResponse<VkConversationsResponse>> getConversations(
      GetConversationsParams params) async {
    final result =
        await _invokeMethod('messages.getConversations', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkConversationsResponse>(
      response: result['response'] == null
          ? null
          : VkConversationsResponse.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkConversationResponse>> getHistory(
      GetHistoryParams params) async {
    final result = await _invokeMethod('messages.getHistory', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkConversationResponse>(
      response: result['response'] == null
          ? null
          : VkConversationResponse.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkMessagesResponse>> getMessages(
      GetMessagesParams params) async {
    final result = await _invokeMethod('messages.getById', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkMessagesResponse>(
      response: result['response'] == null
          ? null
          : VkMessagesResponse.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkFriendsResponse>> getFriends(
      GetFriendsParams params) async {
    final result = await _invokeMethod('friends.get', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkFriendsResponse>(
      response: result['response'] == null
          ? null
          : VkFriendsResponse.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<int>> sendMessage(SendMessageParams params) async {
    final result = await _invokeMethod('messages.send', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<int>(
      response: result['response'] == null ? null : result['response'],
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<Map<String, int>>> deleteMessages(
      DeleteMessagesParams params) async {
    final result = await _invokeMethod('messages.delete', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<Map<String, int>>(
      response: result['response'] == null
          ? null
          : Map<String, int>.from(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkUploadServer>> getPhotoMessagesUploadServer(
      GetPhotoUploadServerParams params) async {
    final result =
        await _invokeMethod('photos.getMessagesUploadServer', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkUploadServer>(
      response: result['response'] == null
          ? null
          : VkUploadServer.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<List<VkPhoto>>> saveMessagesPhoto(
      SaveMessagesPhotoParams params) async {
    final result =
        await _invokeMethod('photos.saveMessagesPhoto', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<List<VkPhoto>>(
      response:
          result["response"] != null && result["response"] is List<dynamic>
              ? List<VkPhoto>.from(result["response"]
                  .map((element) => VkPhoto.fromMap(element))
                  .toList())
              : null,
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkSaveVideo>> saveVideo(SaveVideoParams params) async {
    final result = await _invokeMethod('video.save', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkSaveVideo>(
      response: result['response'] == null
          ? null
          : VkSaveVideo.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkUploadServer>> getAudioUploadServer() async {
    final result = await _invokeMethod('audio.getUploadServer');

    if (result == null) {
      return null;
    }

    return VkResponse<VkUploadServer>(
      response: result['response'] == null
          ? null
          : VkUploadServer.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkAudio>> saveAudio(SaveAudioParams params) async {
    final result = await _invokeMethod('audio.save', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkAudio>(
      response: result['response'] == null
          ? null
          : VkAudio.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkUploadServer>> getDocMessagesUploadServer(
      GetDocMessagesUploadServerParams params) async {
    final result =
        await _invokeMethod('docs.getMessagesUploadServer', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkUploadServer>(
      response: result['response'] == null
          ? null
          : VkUploadServer.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkSaveDoc>> saveDoc(SaveDocParams params) async {
    final result = await _invokeMethod('docs.save', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkSaveDoc>(
      response: result['response'] == null
          ? null
          : VkSaveDoc.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkStoreProductsResponse>> getStickers() async {
    final result = await _invokeMethod('store.getProducts',
        {'filters': 'purchased', 'type': 'stickers', 'extended': '1'});

    if (result == null) {
      return null;
    }

    return VkResponse<VkStoreProductsResponse>(
      response: result['response'] == null
          ? null
          : VkStoreProductsResponse.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<int>> markAsRead(MarkAsReadParams params) async {
    final result = await _invokeMethod('messages.markAsRead', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<int>(
      response: result['response'] == null ? null : result['response'],
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<VkLongPollServer>> getLongPollServer(
      GetLongPollServerParams params) async {
    final result =
        await _invokeMethod('messages.getLongPollServer', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<VkLongPollServer>(
      response: result['response'] == null
          ? null
          : VkLongPollServer.fromMap(result['response']),
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkPollResult> poll(String pollUrl) async {
    final response = await http.get(pollUrl);

    if (response?.body == null) {
      return null;
    }

    Map<String, dynamic> result = json.decode(response?.body);

    return VkPollResult.fromMap(result);
  }

  Future<VkResponse<int>> registerDevice(RegisterDeviceParams params) async {
    final result =
        await _invokeMethod('account.registerDevice', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<int>(
      response: result['response'] == null ? null : result['response'],
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }

  Future<VkResponse<int>> unregisterDevice(
      UnregisterDeviceParams params) async {
    final result =
        await _invokeMethod('account.unregisterDevice', params.toMap());

    if (result == null) {
      return null;
    }

    return VkResponse<int>(
      response: result['response'] == null ? null : result['response'],
      error: result['error'] == null ? null : VkError.fromMap(result['error']),
    );
  }
}
