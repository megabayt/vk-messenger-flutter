import 'package:vk_messenger_flutter/vk_models/photo.dart';

class VkLink {
  VkLink({
    this.url,
    this.title,
    this.caption,
    this.text,
    this.description,
    this.photo,
    this.isFavorite,
  });

  final String url;
  final String title;
  final String caption;
  final String text;
  final String description;
  final VkPhoto photo;
  final bool isFavorite;

  factory VkLink.fromMap(Map<String, dynamic> json) => VkLink(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        text: json["text"] == null ? null : json["text"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : VkPhoto.fromMap(json["photo"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
      );
}
