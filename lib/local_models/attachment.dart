import 'package:vk_messenger_flutter/vk_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';
import 'package:vk_messenger_flutter/local_models/attachment_doc.dart';
import 'package:vk_messenger_flutter/local_models/attachment_audio.dart';
import 'package:vk_messenger_flutter/local_models/attachment_gift.dart';
import 'package:vk_messenger_flutter/local_models/attachment_link.dart';
import 'package:vk_messenger_flutter/local_models/attachment_photo.dart';
import 'package:vk_messenger_flutter/local_models/attachment_poll.dart';
import 'package:vk_messenger_flutter/local_models/attachment_sticker.dart';
import 'package:vk_messenger_flutter/local_models/attachment_story.dart';
import 'package:vk_messenger_flutter/local_models/attachment_video.dart';
import 'package:vk_messenger_flutter/local_models/attachment_wall.dart';
import 'package:vk_messenger_flutter/local_models/attachment_wall_reply.dart';

abstract class Attachment {
  Attachment({
    this.path,
    this.url,
    this.title,
    this.preview,
    this.isFetching = false,
  });

  final String path;
  final String url;
  final String title;
  final String preview;
  final bool isFetching;

  factory Attachment.fromVkAttachment(VkAttachment vkAttachment) {
    final type = vkAttachment.type;

    switch (type) {
      case VkAttachmentType.DOC:
        return AttachmentDoc.fromVkAttachment(vkAttachment);
      case VkAttachmentType.GIFT:
        return AttachmentGift.fromVkAttachment(vkAttachment);
      case VkAttachmentType.LINK:
        return AttachmentLink.fromVkAttachment(vkAttachment);
      case VkAttachmentType.PHOTO:
        return AttachmentPhoto.fromVkAttachment(vkAttachment);
      case VkAttachmentType.POLL:
        return AttachmentPoll.fromVkAttachment(vkAttachment);
      case VkAttachmentType.STICKER:
        return AttachmentSticker.fromVkAttachment(vkAttachment);
      case VkAttachmentType.STORY:
        return AttachmentStory.fromVkAttachment(vkAttachment);
      case VkAttachmentType.VIDEO:
        return AttachmentVideo.fromVkAttachment(vkAttachment);
      case VkAttachmentType.AUDIO:
        return AttachmentAudio.fromVkAttachment(vkAttachment);
      case VkAttachmentType.WALL:
        return AttachmentWall.fromVkAttachment(vkAttachment);
      case VkAttachmentType.WALL_REPLY:
        return AttachmentWallReply.fromVkAttachment(vkAttachment);
      default:
        return null;
    }
  }
}
