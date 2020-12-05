import 'package:vk_messenger_flutter/vk_models/image_size.dart';

class VkSticker {
  VkSticker({
    this.productId,
    this.stickerId,
    this.images,
    this.imagesWithBackground,
    this.animationUrl,
  });

  final int productId;
  final int stickerId;
  final List<VkImageSize> images;
  final List<VkImageSize> imagesWithBackground;
  final String animationUrl;

  factory VkSticker.fromMap(Map<String, dynamic> json) => VkSticker(
        productId: json["product_id"] == null ? null : json["product_id"],
        stickerId: json["sticker_id"] == null ? null : json["sticker_id"],
        images: json["images"] == null
            ? null
            : List<VkImageSize>.from(
                json["images"].map((x) => VkImageSize.fromMap(x))),
        imagesWithBackground: json["images_with_background"] == null
            ? null
            : List<VkImageSize>.from(json["images_with_background"]
                .map((x) => VkImageSize.fromMap(x))),
        animationUrl:
            json["animation_url"] == null ? null : json["animation_url"],
      );
}
