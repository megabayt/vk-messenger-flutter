import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';
import 'package:vk_messenger_flutter/vk_models/audio.dart';
import 'package:vk_messenger_flutter/vk_models/doc.dart';
import 'package:vk_messenger_flutter/vk_models/gift.dart';
import 'package:vk_messenger_flutter/vk_models/link.dart';
import 'package:vk_messenger_flutter/vk_models/photo.dart';
import 'package:vk_messenger_flutter/vk_models/sticker.dart';
import 'package:vk_messenger_flutter/vk_models/story.dart';
import 'package:vk_messenger_flutter/vk_models/video.dart';
import 'package:vk_messenger_flutter/vk_models/wall.dart';
import 'package:vk_messenger_flutter/vk_models/wall_reply.dart';

class VkAttachment {
  VkAttachment({
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

  final VkAttachmentType type;
  final VkPhoto photo;
  final VkLink link;
  final VkWall wall;
  final VkWallReply wallReply;
  final VkSticker sticker;
  final VkDoc doc;
  final VkVideo video;
  final VkStory story;
  final VkGift gift;
  final VkAudio audio;
  final String localPath;

  factory VkAttachment.fromMap(Map<String, dynamic> json) => VkAttachment(
        type: json["type"] == null
            ? null
            : vkAttachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : VkPhoto.fromMap(json["photo"]),
        link: json["link"] == null ? null : VkLink.fromMap(json["link"]),
        wall: json["wall"] == null ? null : VkWall.fromMap(json["wall"]),
        wallReply: json["wall_reply"] == null
            ? null
            : VkWallReply.fromMap(json["wall_reply"]),
        sticker:
            json["sticker"] == null ? null : VkSticker.fromMap(json["sticker"]),
        doc: json["doc"] == null ? null : VkDoc.fromMap(json["doc"]),
        video: json["video"] == null ? null : VkVideo.fromMap(json["video"]),
        story: json["story"] == null ? null : VkStory.fromMap(json["story"]),
        gift: json["gift"] == null ? null : VkGift.fromMap(json["gift"]),
        audio: json["audio"] == null ? null : VkAudio.fromMap(json["audio"]),
      );
}
