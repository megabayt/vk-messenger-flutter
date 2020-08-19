import 'dart:convert';

import 'package:vk_messenger_flutter/models/photo.dart';

class Doc {
    Doc({
        this.id,
        this.ownerId,
        this.title,
        this.preview,
    });

    final int id;
    final int ownerId;
    final String title;
    final DocPreview preview;

    factory Doc.fromRawJson(String str) => Doc.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        preview: json["preview"] == null ? null : DocPreview.fromJson(json["preview"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "title": title == null ? null : title,
        "preview": preview == null ? null : preview.toJson(),
    };
}

class DocPreview {
    DocPreview({
        this.photo,
    });

    final Photo photo;

    factory DocPreview.fromRawJson(String str) => DocPreview.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DocPreview.fromJson(Map<String, dynamic> json) => DocPreview(
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
    );

    Map<String, dynamic> toJson() => {
        "photo": photo == null ? null : photo.toJson(),
    };
}
