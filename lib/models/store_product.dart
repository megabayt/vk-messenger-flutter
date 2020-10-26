import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/icon.dart';
import 'package:vk_messenger_flutter/models/sticker.dart';

class StoreProduct {
    StoreProduct({
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
    final Type type;
    final int purchased;
    final int active;
    final int purchaseDate;
    final String title;
    final List<Sticker> stickers;
    final List<Icon> icon;
    final List<Icon> previews;
    final bool hasAnimation;

    factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        purchased: json["purchased"] == null ? null : json["purchased"],
        active: json["active"] == null ? null : json["active"],
        purchaseDate: json["purchase_date"] == null ? null : json["purchase_date"],
        title: json["title"] == null ? null : json["title"],
        stickers: json["stickers"] == null ? null : List<Sticker>.from(json["stickers"].map((x) => Sticker.fromJson(x))),
        icon: json["icon"] == null ? null : List<Icon>.from(json["icon"].map((x) => Icon.fromJson(x))),
        previews: json["previews"] == null ? null : List<Icon>.from(json["previews"].map((x) => Icon.fromJson(x))),
        hasAnimation: json["has_animation"] == null ? null : json["has_animation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : typeValues.reverse[type],
        "purchased": purchased == null ? null : purchased,
        "active": active == null ? null : active,
        "purchase_date": purchaseDate == null ? null : purchaseDate,
        "title": title == null ? null : title,
        "stickers": stickers == null ? null : List<dynamic>.from(stickers.map((x) => x.toJson())),
        "icon": icon == null ? null : List<dynamic>.from(icon.map((x) => x.toJson())),
        "previews": previews == null ? null : List<dynamic>.from(previews.map((x) => x.toJson())),
        "has_animation": hasAnimation == null ? null : hasAnimation,
    };
}

enum Type { STICKERS }

final typeValues = EnumValues({
    "stickers": Type.STICKERS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
