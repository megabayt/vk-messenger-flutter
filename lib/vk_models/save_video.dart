class VkSaveVideo {
  VkSaveVideo({
    this.uploadUrl,
    this.vid,
    this.ownerId,
    this.name,
    this.description,
    this.accessKey,
  });

  final String uploadUrl;
  final int vid;
  final int ownerId;
  final String name;
  final String description;
  final String accessKey;

  factory VkSaveVideo.fromMap(Map<String, dynamic> json) => VkSaveVideo(
        uploadUrl: json["upload_url"] == null ? null : json["upload_url"],
        vid: json["vid"] == null ? null : json["vid"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
      );
}
