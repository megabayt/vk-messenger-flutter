import 'package:vk_messenger_flutter/vk_models/image_size.dart';

class VkVideo {
  VkVideo({
    this.id,
    this.ownerId,
    this.description,
    this.image,
    this.title,
  });

  final int id;
  final int ownerId;
  final String description;
  final List<VkImageSize> image;
  final String title;

  factory VkVideo.fromMap(Map<String, dynamic> json) => VkVideo(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null
            ? null
            : List<VkImageSize>.from(
                json["image"].map((x) => VkImageSize.fromMap(x))),
        title: json["title"] == null ? null : json["title"],
      );
}
