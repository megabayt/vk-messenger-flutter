import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';

import 'package:vk_messenger_flutter/constants/api.dart' as api;

class VkStore with ChangeNotifier {
  final vk = VKLogin(); // Your application ID
  VKAccessToken _tokenObject;

  get isAuthenticated {
    return _tokenObject != null;
  }
  get token {
    return _tokenObject?.token;
  }

  Future<void> login() async {
    try {
      if (!vk.isInitialized) {
        await vk.initSdk(api.appId);
      }
      final isLoggedIn = await vk.isLoggedIn;
      if (isLoggedIn) {
        _tokenObject = await vk.accessToken;
        return;
      }
      final loginResult = await vk
          .logIn(scope: [VKScope.friends, VKScope.messages, VKScope.offline]);
      if (loginResult.isValue) {
        final loginData = loginResult.asValue.value;
        if (loginData.isCanceled) {
          // Пользователь отменил авторизацию, пробуем снова
          login();
        } else {
          // Вход выполнен
          _tokenObject = loginData.accessToken;
        }
      } else {
        // Словили ошибку авторизации, пробуем снова
        login();
      }
    } catch (_) {
      // Словили исключение, пробуем снова
      login();
    }
  }
}
