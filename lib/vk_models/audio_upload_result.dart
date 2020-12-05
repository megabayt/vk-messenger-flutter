class VkAudioUploadResult {
  VkAudioUploadResult({
    this.server,
    this.audio,
    this.redirect,
    this.hash,
  });

  final int server;
  final String audio;
  final String redirect;
  final String hash;

  factory VkAudioUploadResult.fromMap(Map<String, dynamic> json) =>
      VkAudioUploadResult(
        server: json["server"] == null ? null : json["server"],
        audio: json["audio"] == null ? null : json["audio"],
        redirect: json["redirect"] == null ? null : json["redirect"],
        hash: json["hash"] == null ? null : json["hash"],
      );
}
