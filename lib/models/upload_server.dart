class UploadServer {
  final String uploadUrl;
  final int albumId;
  final int userId;

  UploadServer({
    this.uploadUrl,
    this.albumId,
    this.userId,
  });

  factory UploadServer.fromJson(Map<String, dynamic> json) => UploadServer(
        uploadUrl: json["upload_url"] == null ? null : json["upload_url"],
        albumId: json["album_id"] == null ? null : json["album_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "upload_url": uploadUrl == null ? null : uploadUrl,
        "album_id": albumId == null ? null : albumId,
        "user_id": userId == null ? null : userId,
      };
}
