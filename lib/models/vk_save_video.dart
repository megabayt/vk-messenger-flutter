import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkSaveVideoResponseBody {
  VkSaveVideoResponseBody({
    @required this.response,
    this.error,
  });

  final VkSaveVideoResponse response;
  final VkError error;

  factory VkSaveVideoResponseBody.fromJson(Map<String, dynamic> json) =>
      VkSaveVideoResponseBody(
        response: json["response"] == null
            ? null
            : VkSaveVideoResponse.fromJson(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}

class VkSaveVideoResponse {
  VkSaveVideoResponse({
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

  factory VkSaveVideoResponse.fromJson(Map<String, dynamic> json) =>
      VkSaveVideoResponse(
        uploadUrl: json["upload_url"] == null ? null : json["upload_url"],
        vid: json["vid"] == null ? null : json["vid"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
      );

  Map<String, dynamic> toJson() => {
        "upload_url": uploadUrl == null ? null : uploadUrl,
        "vid": vid == null ? null : vid,
        "owner_id": ownerId == null ? null : ownerId,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "access_key": accessKey == null ? null : accessKey,
      };
}
