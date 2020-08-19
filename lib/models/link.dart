import 'dart:convert';

import 'package:vk_messenger_flutter/models/photo.dart';

class Link {
    Link({
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
    final Photo photo;
    final bool isFavorite;

    factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        text: json["text"] == null ? null : json["text"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "caption": caption == null ? null : caption,
        "text": text == null ? null : text,
        "description": description == null ? null : description,
        "photo": photo == null ? null : photo.toJson(),
        "is_favorite": isFavorite == null ? null : isFavorite,
    };
}
