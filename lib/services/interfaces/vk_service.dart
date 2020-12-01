abstract class VKService {
  String get token;
  int get userId;

  Future<void> login();
  Future<void> logout();

  Future<Map<String, dynamic>> getConversations(Map<String, String> params);

  Future<Map<String, dynamic>> getHistory(Map<String, String> params);

  Future<Map<String, dynamic>> getMessages(Map<String, String> params);

  Future<Map<String, dynamic>> getFriends(Map<String, String> params);

  Future<Map<String, dynamic>> sendMessage(Map<String, String> params);

  Future<Map<String, dynamic>> deleteMessages(Map<String, String> params);

  Future<Map<String, dynamic>> getPhotoMessagesUploadServer(
      Map<String, String> params);

  Future<Map<String, dynamic>> saveMessagesPhoto(Map<String, String> params);

  Future<Map<String, dynamic>> saveVideo(Map<String, String> params);

  Future<Map<String, dynamic>> getAudioUploadServer();

  Future<Map<String, dynamic>> saveAudio(Map<String, String> params);

  Future<Map<String, dynamic>> getDocMessagesUploadServer(
      Map<String, String> params);

  Future<Map<String, dynamic>> saveDoc(Map<String, String> params);

  Future<Map<String, dynamic>> getStickers();

  Future<Map<String, dynamic>> markAsRead(Map<String, String> params);

  Future<Map<String, dynamic>> getLongPollServer(Map<String, String> params);

  Future<Map<String, dynamic>> poll(String pollUrl);
}
