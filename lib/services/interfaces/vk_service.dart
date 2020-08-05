import 'package:flutter_login_vk/flutter_login_vk.dart';

abstract class VKService {
  VKLogin _instance;
  VKAccessToken _tokenObject;

  get token;

  Future<void> login();
}
