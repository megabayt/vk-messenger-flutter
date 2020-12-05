import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/vk_models/icon.dart';
import 'package:vk_messenger_flutter/vk_models/sticker.dart';
import 'package:vk_messenger_flutter/vk_models/store_product_type.dart';

class VkStoreProduct {
  VkStoreProduct({
    @required this.id,
    @required this.type,
    @required this.purchased,
    @required this.active,
    @required this.purchaseDate,
    @required this.title,
    @required this.stickers,
    @required this.icon,
    @required this.previews,
    @required this.hasAnimation,
  });

  final int id;
  final VkStoreProductType type;
  final int purchased;
  final int active;
  final int purchaseDate;
  final String title;
  final List<VkSticker> stickers;
  final List<VkIcon> icon;
  final List<VkIcon> previews;
  final bool hasAnimation;

  factory VkStoreProduct.fromMap(Map<String, dynamic> json) => VkStoreProduct(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null
            ? null
            : vkStoreProductTypeValues.map[json["type"]],
        purchased: json["purchased"] == null ? null : json["purchased"],
        active: json["active"] == null ? null : json["active"],
        purchaseDate:
            json["purchase_date"] == null ? null : json["purchase_date"],
        title: json["title"] == null ? null : json["title"],
        stickers: json["stickers"] == null
            ? null
            : List<VkSticker>.from(
                json["stickers"].map((x) => VkSticker.fromMap(x))),
        icon: json["icon"] == null
            ? null
            : List<VkIcon>.from(json["icon"].map((x) => VkIcon.fromMap(x))),
        previews: json["previews"] == null
            ? null
            : List<VkIcon>.from(json["previews"].map((x) => VkIcon.fromMap(x))),
        hasAnimation:
            json["has_animation"] == null ? null : json["has_animation"],
      );
}
