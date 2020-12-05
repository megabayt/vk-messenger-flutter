class SaveAudioParams {
  final String audio;
  final int server;
  final String hash;

  SaveAudioParams({
    this.audio,
    this.server,
    this.hash,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (audio != null) {
      map['audio'] = audio;
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
