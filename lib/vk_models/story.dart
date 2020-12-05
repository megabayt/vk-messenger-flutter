import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';
import 'package:vk_messenger_flutter/vk_models/link.dart';
import 'package:vk_messenger_flutter/vk_models/photo.dart';
import 'package:vk_messenger_flutter/vk_models/video.dart';

class VkStory {
  VkStory({
    this.id,
    this.ownerId,
    this.expiresAt,
    this.link,
    this.photo,
    this.video,
    this.type,
    this.isExpired,
  });

  final int id;
  final int ownerId;
  final int expiresAt;
  final VkLink link;
  final VkPhoto photo;
  final VkVideo video;
  final VkAttachmentType type;
  final bool isExpired;

  factory VkStory.fromMap(Map<String, dynamic> json) => VkStory(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        expiresAt: json["expires_at"] == null ? null : json["expires_at"],
        type: json["type"] == null
            ? null
            : vkAttachmentTypeValues.map[json["type"]],
        link: json["link"] == null ? null : VkLink.fromMap(json["link"]),
        photo: json["photo"] == null ? null : VkPhoto.fromMap(json["photo"]),
        video: json["video"] == null ? null : VkVideo.fromMap(json["video"]),
        isExpired: json["is_expired"] == null ? null : json["is_expired"],
      );
}
