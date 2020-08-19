import 'dart:convert';

import 'package:vk_messenger_flutter/utils/enum_values.dart';

class Photo {
    Photo({
        this.id,
        this.ownerId,
        this.sizes,
    });

    final int id;
    final int ownerId;
    final List<ImageSize> sizes;

    factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        sizes: json["sizes"] == null ? null : List<ImageSize>.from(json["sizes"].map((x) => ImageSize.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "sizes": sizes == null ? null : List<dynamic>.from(sizes.map((x) => x.toJson())),
    };
}

class ImageSize {
    ImageSize({
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
    final SizeType type;
    final String url;
    final int withPadding;
    final int fileSize;

    factory ImageSize.fromRawJson(String str) => ImageSize.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ImageSize.fromJson(Map<String, dynamic> json) => ImageSize(
        src: json["src"] == null ? null : json["src"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        type: json["type"] == null ? null : sizeTypeValues.map[json["type"]],
        url: json["url"] == null ? null : json["url"],
        withPadding: json["with_padding"] == null ? null : json["with_padding"],
        fileSize: json["file_size"] == null ? null : json["file_size"],
    );

    Map<String, dynamic> toJson() => {
        "src": src == null ? null : src,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "type": type == null ? null : sizeTypeValues.reverse[type],
        "url": url == null ? null : url,
        "with_padding": withPadding == null ? null : withPadding,
        "file_size": fileSize == null ? null : fileSize,
    };
}

enum SizeType { M, S, X, Y, Z, O, I, D, K, L, P, Q, R, W }

final sizeTypeValues = EnumValues({
    "d": SizeType.D,
    "i": SizeType.I,
    "k": SizeType.K,
    "l": SizeType.L,
    "m": SizeType.M,
    "o": SizeType.O,
    "p": SizeType.P,
    "q": SizeType.Q,
    "r": SizeType.R,
    "s": SizeType.S,
    "w": SizeType.W,
    "x": SizeType.X,
    "y": SizeType.Y,
    "z": SizeType.Z
});
