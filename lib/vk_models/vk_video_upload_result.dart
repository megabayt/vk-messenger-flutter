class VkVideoUploadResult {
  VkVideoUploadResult({
    this.size,
    this.videoId,
  });

  final int size;
  final int videoId;

  factory VkVideoUploadResult.fromMap(Map<String, dynamic> json) =>
      VkVideoUploadResult(
        size: json["size"] == null ? null : json["size"],
        videoId: json["video_id"] == null ? null : json["video_id"],
      );
}
