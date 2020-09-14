import 'dart:convert';

import 'package:vk_messenger_flutter/models/audio.dart';
import 'package:vk_messenger_flutter/models/doc.dart';
import 'package:vk_messenger_flutter/models/gift.dart';
import 'package:vk_messenger_flutter/models/link.dart';
import 'package:vk_messenger_flutter/models/photo.dart';
import 'package:vk_messenger_flutter/models/sticker.dart';
import 'package:vk_messenger_flutter/models/story.dart';
import 'package:vk_messenger_flutter/models/video.dart';
import 'package:vk_messenger_flutter/models/wall.dart';
import 'package:vk_messenger_flutter/models/wall_reply.dart';
import 'package:vk_messenger_flutter/utils/enum_values.dart';

class Attachment {
    Attachment({
        this.type,
        this.photo,
        this.link,
        this.wall,
        this.sticker,
        this.doc,
        this.wallReply,
        this.video,
        this.story,
        this.gift,
        this.audio,
        this.localPath = '',
    });

    final AttachmentType type;
    final Photo photo;
    final Link link;
    final Wall wall;
    final WallReply wallReply;
    final Sticker sticker;
    final Doc doc;
    final Video video;
    final Story story;
    final Gift gift;
    final Audio audio;
    final String localPath;

    factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : Photo.fromJson(json["photo"]),
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        wall: json["wall"] == null ? null : Wall.fromJson(json["wall"]),
        wallReply: json["wall_reply"] == null ? null : WallReply.fromJson(json["wall_reply"]),
        sticker: json["sticker"] == null ? null : Sticker.fromJson(json["sticker"]),
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
        gift: json["gift"] == null ? null : Gift.fromJson(json["gift"]),
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "photo": photo == null ? null : photo.toJson(),
        "link": link == null ? null : link.toJson(),
        "wall": wall == null ? null : wall.toJson(),
        "wall_reply": wallReply == null ? null : wallReply.toJson(),
        "sticker": sticker == null ? null : sticker.toJson(),
        "doc": doc == null ? null : doc.toJson(),
        "video": video == null ? null : video.toJson(),
        "story": story == null ? null : story.toJson(),
        "gift": gift == null ? null : gift.toJson(),
        "audio": audio == null ? null : audio.toJson(),
    };
}

enum AttachmentType { PHOTO, LINK, WALL, STICKER, DOC, WALL_REPLY, VIDEO, STORY, POLL, GIFT, AUDIO }

final attachmentTypeValues = EnumValues({
    "doc": AttachmentType.DOC,
    "link": AttachmentType.LINK,
    "photo": AttachmentType.PHOTO,
    "poll": AttachmentType.POLL,
    "sticker": AttachmentType.STICKER,
    "story": AttachmentType.STORY,
    "video": AttachmentType.VIDEO,
    "wall": AttachmentType.WALL,
    "wall_reply": AttachmentType.WALL_REPLY,
    "gift": AttachmentType.GIFT,
    "audio": AttachmentType.AUDIO,
});
