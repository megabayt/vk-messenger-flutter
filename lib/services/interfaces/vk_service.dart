abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
}
