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
import 'package:vk_messenger_flutter/models/attachment.dart' as AttachmentModel;
import 'package:vk_messenger_flutter/utils/helpers.dart';

class Attachment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment =
        Provider.of<AttachmentModel.Attachment>(context, listen: false);

    switch (attachment.type) {
      case AttachmentModel.AttachmentType.PHOTO:
        return AttachmentPhoto();
      case AttachmentModel.AttachmentType.VIDEO:
        return AttachmentVideo();
      case AttachmentModel.AttachmentType.GIFT:
        return AttachmentGift();
      case AttachmentModel.AttachmentType.STICKER:
        return AttachmentSticker();
      case AttachmentModel.AttachmentType.DOC:
        return AttachmentDoc();
      case AttachmentModel.AttachmentType.STORY:
        return AttachmentStory();
      case AttachmentModel.AttachmentType.AUDIO:
        return AttachmentAudio();
      case AttachmentModel.AttachmentType.LINK:
        return AttachmentLink();
      case AttachmentModel.AttachmentType.POLL:
        return AttachmentPoll();
      case AttachmentModel.AttachmentType.WALL:
        return AttachmentWall();
      case AttachmentModel.AttachmentType.WALL_REPLY:
        return AttachmentWallReply();
      default:
        final text = getAttachmentReplacer(attachment);
        return Text(
          text,
        );
    }
  }
}
