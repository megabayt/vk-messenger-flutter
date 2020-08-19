import 'dart:convert';

import 'package:vk_messenger_flutter/models/photo.dart';

class Video {
    Video({
        this.id,
        this.ownerId,
        this.description,
        this.image,
        this.title,
    });

    final int id;
    final int ownerId;
    final String description;
    final List<ImageSize> image;
    final String title;

    factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : List<ImageSize>.from(json["image"].map((x) => ImageSize.fromJson(x))),
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
    };
}