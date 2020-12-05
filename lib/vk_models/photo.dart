import 'package:vk_messenger_flutter/vk_models/image_size.dart';

class VkPhoto {
  VkPhoto({
    this.id,
    this.ownerId,
    this.sizes,
  });

  final int id;
  final int ownerId;
  final List<VkImageSize> sizes;

  factory VkPhoto.fromMap(Map<String, dynamic> json) => VkPhoto(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        sizes: json["sizes"] == null
            ? null
            : List<VkImageSize>.from(
                json["sizes"].map((x) => VkImageSize.fromMap(x))),
      );
}
