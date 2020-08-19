import 'dart:convert';

import 'package:vk_messenger_flutter/models/photo.dart';

class Sticker {
    Sticker({
        this.productId,
        this.stickerId,
        this.images,
        this.imagesWithBackground,
        this.animationUrl,
    });

    final int productId;
    final int stickerId;
    final List<ImageSize> images;
    final List<ImageSize> imagesWithBackground;
    final String animationUrl;

    factory Sticker.fromRawJson(String str) => Sticker.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sticker.fromJson(Map<String, dynamic> json) => Sticker(
        productId: json["product_id"] == null ? null : json["product_id"],
        stickerId: json["sticker_id"] == null ? null : json["sticker_id"],
        images: json["images"] == null ? null : List<ImageSize>.from(json["images"].map((x) => ImageSize.fromJson(x))),
        imagesWithBackground: json["images_with_background"] == null ? null : List<ImageSize>.from(json["images_with_background"].map((x) => ImageSize.fromJson(x))),
        animationUrl: json["animation_url"] == null ? null : json["animation_url"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "sticker_id": stickerId == null ? null : stickerId,
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
        "images_with_background": imagesWithBackground == null ? null : List<dynamic>.from(imagesWithBackground.map((x) => x.toJson())),
        "animation_url": animationUrl == null ? null : animationUrl,
    };
}
