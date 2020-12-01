import 'dart:convert';

import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:http/http.dart' as http;

import 'package:vk_messenger_flutter/constants/api.dart' as api;
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/errors.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

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

  Future<Map<String, dynamic>> _invokeMethod(String method,
      [Map<String, String> params]) async {
    var url =
        '${api.BASE_URL}$method?access_token=$token&v=${api.VERSION}&extended=1';

    if (params != null) {
      url += serialize(params);
    }

    final response = await http.get(url);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    return responseBody;
  }

  Future<Map<String, dynamic>> getConversations(
      Map<String, String> params) async {
    return _invokeMethod('messages.getConversations', params);
  }

  Future<Map<String, dynamic>> getHistory(Map<String, String> params) async {
    return _invokeMethod('messages.getHistory', params);
  }

  Future<Map<String, dynamic>> getMessages(Map<String, String> params) async {
    return _invokeMethod('messages.getById', params);
  }

  Future<Map<String, dynamic>> getFriends(Map<String, String> params) async {
    return _invokeMethod('friends.get', params);
  }

  Future<Map<String, dynamic>> sendMessage(Map<String, String> params) async {
    return _invokeMethod('messages.send', params);
  }

  Future<Map<String, dynamic>> deleteMessages(
      Map<String, String> params) async {
    return _invokeMethod('messages.delete', params);
  }

  Future<Map<String, dynamic>> getPhotoMessagesUploadServer(
      Map<String, String> params) async {
    return _invokeMethod('photos.getMessagesUploadServer', params);
  }

  Future<Map<String, dynamic>> saveMessagesPhoto(
      Map<String, String> params) async {
    return _invokeMethod('photos.saveMessagesPhoto', params);
  }

  Future<Map<String, dynamic>> saveVideo(Map<String, String> params) async {
    return _invokeMethod('video.save', params);
  }

  Future<Map<String, dynamic>> getAudioUploadServer() async {
    return _invokeMethod('audio.getUploadServer');
  }

  Future<Map<String, dynamic>> saveAudio(Map<String, String> params) async {
    return _invokeMethod('audio.save', params);
  }

  Future<Map<String, dynamic>> getDocMessagesUploadServer(
      Map<String, String> params) async {
    return _invokeMethod('docs.getMessagesUploadServer', params);
  }

  Future<Map<String, dynamic>> saveDoc(Map<String, String> params) async {
    return _invokeMethod('docs.save', params);
  }

  Future<Map<String, dynamic>> getStickers() async {
    return _invokeMethod(
        'store.getProducts', {'filters': 'purchased', 'type': 'stickers'});
  }

  Future<Map<String, dynamic>> markAsRead(Map<String, String> params) async {
    return _invokeMethod('messages.markAsRead', params);
  }

  Future<Map<String, dynamic>> getLongPollServer(
      Map<String, String> params) async {
    return _invokeMethod('messages.getLongPollServer', params);
  }

  Future<Map<String, dynamic>> poll(String pollUrl) async {
    final response = await http.get(pollUrl);

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    return responseBody;
  }
}
