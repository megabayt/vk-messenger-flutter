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

import 'package:vk_messenger_flutter/local_models/attachment_doc.dart'
    as AttachmentDocModel;
import 'package:vk_messenger_flutter/local_models/attachment_audio.dart'
    as AttachmentAudioModel;
import 'package:vk_messenger_flutter/local_models/attachment_gift.dart'
    as AttachmentGiftModel;
import 'package:vk_messenger_flutter/local_models/attachment_link.dart'
    as AttachmentLinkModel;
import 'package:vk_messenger_flutter/local_models/attachment_photo.dart'
    as AttachmentPhotoModel;
import 'package:vk_messenger_flutter/local_models/attachment_poll.dart'
    as AttachmentPollModel;
import 'package:vk_messenger_flutter/local_models/attachment_sticker.dart'
    as AttachmentStickerModel;
import 'package:vk_messenger_flutter/local_models/attachment_story.dart'
    as AttachmentStoryModel;
import 'package:vk_messenger_flutter/local_models/attachment_video.dart'
    as AttachmentVideoModel;
import 'package:vk_messenger_flutter/local_models/attachment_wall.dart'
    as AttachmentWallModel;
import 'package:vk_messenger_flutter/local_models/attachment_wall_reply.dart'
    as AttachmentWallReplyModel;

import 'package:vk_messenger_flutter/local_models/attachment.dart'
    as AttachmentModel;

class Attachment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment =
        Provider.of<AttachmentModel.Attachment>(context, listen: false);

    if (attachment is AttachmentPhotoModel.AttachmentPhoto) {
      return AttachmentPhoto();
    } else if (attachment is AttachmentVideoModel.AttachmentVideo) {
      return AttachmentVideo();
    } else if (attachment is AttachmentGiftModel.AttachmentGift) {
      return AttachmentGift();
    } else if (attachment is AttachmentStickerModel.AttachmentSticker) {
      return AttachmentSticker();
    } else if (attachment is AttachmentDocModel.AttachmentDoc) {
      return AttachmentDoc();
    } else if (attachment is AttachmentStoryModel.AttachmentStory) {
      return AttachmentStory();
    } else if (attachment is AttachmentAudioModel.AttachmentAudio) {
      return AttachmentAudio();
    } else if (attachment is AttachmentLinkModel.AttachmentLink) {
      return AttachmentLink();
    } else if (attachment is AttachmentPollModel.AttachmentPoll) {
      return AttachmentPoll();
    } else if (attachment is AttachmentWallModel.AttachmentWall) {
      return AttachmentWall();
    } else if (attachment is AttachmentWallReplyModel.AttachmentWallReply) {
      return AttachmentWallReply();
    } else {
      return Text(attachment?.title ?? 'Вложение');
    }
  }
}
