import 'package:vk_messenger_flutter/vk_models/doc_preview.dart';

class VkDoc {
  VkDoc({
    this.id,
    this.ownerId,
    this.title,
    this.preview,
  });

  final int id;
  final int ownerId;
  final String title;
  final VkDocPreview preview;

  factory VkDoc.fromMap(Map<String, dynamic> json) => VkDoc(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        preview: json["preview"] == null
            ? null
            : VkDocPreview.fromMap(json["preview"]),
      );
}
