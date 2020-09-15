import 'dart:convert';

import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:http/http.dart' as http;

import 'package:vk_messenger_flutter/constants/api.dart' as api;
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/models/vk_delete_messages.dart';
import 'package:vk_messenger_flutter/models/vk_friends.dart';
import 'package:vk_messenger_flutter/models/vk_messages.dart';
import 'package:vk_messenger_flutter/models/vk_photo_messages_upload_server.dart';
import 'package:vk_messenger_flutter/models/vk_save_messages_photo.dart';
import 'package:vk_messenger_flutter/models/vk_save_video.dart';
import 'package:vk_messenger_flutter/models/vk_send_message.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/utils/errors.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class VkServiceImpl implements VKService {
  final _instance = VKLogin(); // Your application ID
  VKAccessToken _tokenObject;
  ProfilesService _profilesService = locator<ProfilesService>();

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
      VKScope.offline
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

  Future<VkConversationsResponseBody> getConversations(
      Map<String, String> params) async {
    final getConversationsUrl =
        '${api.BASE_URL}messages.getConversations?access_token=$token&v=${api.VERSION}&extended=1${serialize(params)}';

    final response = await http.get(getConversationsUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }

    final conversations = VkConversationsResponseBody.fromJson(responseBody);

    _profilesService.appendProfiles(conversations?.response?.profiles);
    _profilesService.appendGroups(conversations?.response?.groups);

    return conversations;
  }

  Future<VkConversationResponseBody> getHistory(
      Map<String, String> params) async {
    final getHistoryUrl =
        '${api.BASE_URL}messages.getHistory?access_token=$token&v=${api.VERSION}&extended=1${serialize(params)}';

    final response = await http.get(getHistoryUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    final conversation = VkConversationResponseBody.fromJson(responseBody);

    _profilesService.appendProfiles(conversation?.response?.profiles);
    _profilesService.appendGroups(conversation?.response?.groups);

    return conversation;
  }

  Future<VkMessagesResponseBody> getMessages(Map<String, String> params) async {
    final getMessagesUrl =
        '${api.BASE_URL}messages.getById?access_token=$token&v=${api.VERSION}&extended=1${serialize(params)}';

    final response = await http.get(getMessagesUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    final messages = VkMessagesResponseBody.fromJson(responseBody);

    return messages;
  }

  Future<VkFriendsResponseBody> getFriends(Map<String, String> params) async {
    final getFriendsUrl =
        '${api.BASE_URL}friends.get?access_token=$token&v=${api.VERSION}&extended=1${serialize(params)}';

    final response = await http.get(getFriendsUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    final friends = VkFriendsResponseBody.fromJson(responseBody);

    return friends;
  }

  Future<VkSendMessageResponseBody> sendMessage(
      Map<String, String> params) async {
    final sendMessageUrl =
        '${api.BASE_URL}messages.send?access_token=$token&v=${api.VERSION}&extended=1' +
            '${serialize(params)}';

    final response = await http.get(sendMessageUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    return VkSendMessageResponseBody.fromJson(responseBody);
  }

  Future<VkDeleteMessagesResponseBody> deleteMessages(
      Map<String, String> params) async {
    final deleteMessagesUrl =
        '${api.BASE_URL}messages.delete?access_token=$token&v=${api.VERSION}&extended=1' +
            '${serialize(params)}';

    final response = await http.get(deleteMessagesUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    return VkDeleteMessagesResponseBody.fromJson(responseBody);
  }

  Future<VkPhotoMessagesUploadServerResponseBody> getPhotoMessagesUploadServer(
      Map<String, String> params) async {
    final getUploadServerUrl =
        '${api.BASE_URL}photos.getMessagesUploadServer?access_token=$token&v=${api.VERSION}&extended=1' +
            '${serialize(params)}';

    final response = await http.get(getUploadServerUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    return VkPhotoMessagesUploadServerResponseBody.fromJson(responseBody);
  }

  Future<VkSaveMessagesPhoto> saveMessagesPhoto(
      Map<String, String> params) async {
    final saveMessagesPhotoUrl =
        '${api.BASE_URL}photos.saveMessagesPhoto?access_token=$token&v=${api.VERSION}&extended=1' +
            '${serialize(params)}';

    final response = await http.get(saveMessagesPhotoUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    return VkSaveMessagesPhoto.fromJson(responseBody);
  }

  Future<VkSaveVideoResponseBody> saveVideo(Map<String, String> params) async {
    final saveVideoUrl =
        '${api.BASE_URL}video.save?access_token=$token&v=${api.VERSION}&extended=1' +
            '${serialize(params)}';

    final response = await http.get(saveVideoUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    return VkSaveVideoResponseBody.fromJson(responseBody);
  }
}
