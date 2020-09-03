import 'dart:convert';

import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:http/http.dart' as http;

import 'package:vk_messenger_flutter/constants/api.dart' as api;
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
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
    try {
      if (!_instance.isInitialized) {
        await _instance.initSdk(api.appId);
      }
      final isLoggedIn = await _instance.isLoggedIn;
      if (isLoggedIn) {
        _tokenObject = await _instance.accessToken;
        return;
      }
      final loginResult = await _instance
          .logIn(scope: [VKScope.friends, VKScope.messages, VKScope.offline]);
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
    } catch (error) {
      // Словили исключение, пробуем снова
      throw VKServiceError(error);
    }
  }

  Future<void> logout() {
    return _instance.logOut();
  }

  Future<VkConversationsResponseBody> getConversations(Map<String, String> params) async {
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

  Future<VkConversationResponseBody> getHistory(Map<String, String> params) async {
    final getConversationUrl =
        '${api.BASE_URL}messages.getHistory?access_token=$token&v=${api.VERSION}&extended=1${serialize(params)}';

    final response = await http.get(getConversationUrl);

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

  Future<int> sendMessage(Map<String, String> params) async {
    final sendMessageUrl =
        '${api.BASE_URL}messages.send?access_token=$token&v=${api.VERSION}&extended=1'
        +'${serialize(params)}';

    final response = await http.get(sendMessageUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    return responseBody != null ? responseBody['response'] : null;
  }
}
