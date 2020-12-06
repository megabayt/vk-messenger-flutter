import 'package:vk_messenger_flutter/vk_models/size_type.dart';

class VkImageSize {
  VkImageSize({
    this.src,
    this.width,
    this.height,
    this.type,
    this.url,
    this.withPadding,
    this.fileSize,
  });

  final String src;
  final int width;
  final int height;
  final VkSizeType type;
  final String url;
  final int withPadding;
  final int fileSize;

  factory VkImageSize.fromMap(Map<String, dynamic> json) => VkImageSize(
        src: json["src"] == null ? null : json["src"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        type: json["type"] == null ? null : vkSizeTypeValues.map[json["type"]],
        url: json["url"] == null ? null : json["url"],
        withPadding: json["with_padding"] == null ? null : json["with_padding"],
        fileSize: json["file_size"] == null ? null : json["file_size"],
      );
}
