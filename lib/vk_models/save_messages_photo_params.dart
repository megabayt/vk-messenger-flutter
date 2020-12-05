class SaveMessagesPhotoParams {
  final String photo;
  final int server;
  final String hash;

  SaveMessagesPhotoParams({
    this.photo,
    this.server,
    this.hash,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (photo != null) {
      map['photo'] = photo;
    }
    if (server != null) {
      map['server'] = server.toString();
    }
    if (hash != null) {
      map['hash'] = hash;
    }
    return map;
  }
}
