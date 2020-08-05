import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/service_locator.dart';
import 'package:vk_messenger_flutter/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/errors.dart';

class AuthStore with ChangeNotifier {
  VKService _vkService = locator<VKService>();

  get isAuthenticated {
    return _vkService.token != null;
  }

  Future<void> login() async {
    try {
      await _vkService.login();
      notifyListeners();
    } on VKServiceError catch (_) {
      // Словили исключение, пробуем снова
      login();
    }
  }
}
