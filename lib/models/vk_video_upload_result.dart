import 'package:meta/meta.dart';
import 'dart:convert';

VkVideoUploadResult vkVideoUploadResultFromJson(String str) =>
    VkVideoUploadResult.fromJson(json.decode(str));

String vkVideoUploadResultToJson(VkVideoUploadResult data) =>
    json.encode(data.toJson());

class VkVideoUploadResult {
  VkVideoUploadResult({
    @required this.size,
    @required this.videoId,
  });

  final int size;
  final int videoId;

  factory VkVideoUploadResult.fromJson(Map<String, dynamic> json) =>
      VkVideoUploadResult(
        size: json["size"] == null ? null : json["size"],
        videoId: json["video_id"] == null ? null : json["video_id"],
      );

  Map<String, dynamic> toJson() => {
        "size": size == null ? null : size,
        "video_id": videoId == null ? null : videoId,
      };
}
