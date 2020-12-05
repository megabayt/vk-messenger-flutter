class VkPhotoUploadResult {
  VkPhotoUploadResult({
    this.server,
    this.photo,
    this.hash,
  });

  final int server;
  final String photo;
  final String hash;

  factory VkPhotoUploadResult.fromMap(Map<String, dynamic> json) =>
      VkPhotoUploadResult(
        server: json["server"] == null ? null : json["server"],
        photo: json["photo"] == null ? null : json["photo"],
        hash: json["hash"] == null ? null : json["hash"],
      );
}
