import 'dart:convert';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/link.dart';
import 'package:vk_messenger_flutter/models/photo.dart';
import 'package:vk_messenger_flutter/models/video.dart';

class Story {
    Story({
        this.id,
        this.ownerId,
        this.expiresAt,
        this.link,
        this.photo,
        this.video,
        this.type,
        this.isExpired,
    });

    final int id;
    final int ownerId;
    final int expiresAt;
    final Link link;
    final Photo photo;
    final Video video;
    final AttachmentType type;
    final bool isExpired;

    factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        expiresAt: json["expires_at"] == null ? null : json["expires_at"],
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        isExpired: json["is_expired"] == null ? null : json["is_expired"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "expires_at": expiresAt == null ? null : expiresAt,
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "link": link == null ? null : link.toJson(),
        "photo": photo == null ? null : photo.toJson(),
        "video": video == null ? null : video.toJson(),
        "is_expired": isExpired == null ? null : isExpired,
    };
}
