import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_gift.g.dart';

@CopyWith()
class AttachmentGift extends Attachment {
  AttachmentGift({
    String path,
    String url,
    String title = 'Подарок',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentGift.fromVkAttachment(VkAttachment vkAttachment) {
    return AttachmentGift(
      title: 'Подарок',
      preview: vkAttachment?.gift?.thumb96,
    );
  }
}
