class VkUploadServer {
  final String uploadUrl;
  final int albumId;
  final int userId;

  VkUploadServer({
    this.uploadUrl,
    this.albumId,
    this.userId,
  });

  factory VkUploadServer.fromMap(Map<String, dynamic> json) => VkUploadServer(
        uploadUrl: json["upload_url"] == null ? null : json["upload_url"],
        albumId: json["album_id"] == null ? null : json["album_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );
}
