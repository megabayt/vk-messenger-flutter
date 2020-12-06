import 'package:vk_messenger_flutter/vk_models/photo.dart';

class VkDocPreview {
  VkDocPreview({
    this.photo,
  });

  final VkPhoto photo;

  factory VkDocPreview.fromMap(Map<String, dynamic> json) => VkDocPreview(
        photo: json["photo"] == null ? null : VkPhoto.fromMap(json["photo"]),
      );
}
