import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/widgets/attachment_audio.dart';
import 'package:vk_messenger_flutter/widgets/attachment_doc.dart';
import 'package:vk_messenger_flutter/widgets/attachment_gift.dart';
import 'package:vk_messenger_flutter/widgets/attachment_link.dart';
import 'package:vk_messenger_flutter/widgets/attachment_photo.dart';
import 'package:vk_messenger_flutter/widgets/attachment_poll.dart';
import 'package:vk_messenger_flutter/widgets/attachment_sticker.dart';
import 'package:vk_messenger_flutter/widgets/attachment_story.dart';
import 'package:vk_messenger_flutter/widgets/attachment_video.dart';
import 'package:vk_messenger_flutter/widgets/attachment_wall.dart';
import 'package:vk_messenger_flutter/widgets/attachment_wall_reply.dart';
import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';
import 'package:vk_messenger_flutter/local_models/attachment.dart'
    as AttachmentModel;

class Attachment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment =
        Provider.of<AttachmentModel.Attachment>(context, listen: false);

    switch (attachment.type) {
      case VkAttachmentType.PHOTO:
        return AttachmentPhoto();
      case VkAttachmentType.VIDEO:
        return AttachmentVideo();
      case VkAttachmentType.GIFT:
        return AttachmentGift();
      case VkAttachmentType.STICKER:
        return AttachmentSticker();
      case VkAttachmentType.DOC:
        return AttachmentDoc();
      case VkAttachmentType.STORY:
        return AttachmentStory();
      case VkAttachmentType.AUDIO:
        return AttachmentAudio();
      case VkAttachmentType.LINK:
        return AttachmentLink();
      case VkAttachmentType.POLL:
        return AttachmentPoll();
      case VkAttachmentType.WALL:
        return AttachmentWall();
      case VkAttachmentType.WALL_REPLY:
        return AttachmentWallReply();
      default:
        return Text(attachment?.title ?? 'Вложение');
    }
  }
}
