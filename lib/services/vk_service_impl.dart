import 'package:flutter_login_vk/flutter_login_vk.dart';

import 'package:vk_messenger_flutter/constants/api.dart' as api;
import 'package:vk_messenger_flutter/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/errors.dart';

class VkServiceImpl implements VKService {
  final _instance = VKLogin(); // Your application ID
  VKAccessToken _tokenObject;

  get token {
    return _tokenObject?.token;
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
}
