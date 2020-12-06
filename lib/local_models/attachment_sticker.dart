import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_sticker.g.dart';

@CopyWith()
class AttachmentSticker extends Attachment {
  AttachmentSticker({
    String path,
    String url,
    String title = 'Стикер',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentSticker.fromVkAttachment(VkAttachment vkAttachment) {
    final sizes = vkAttachment?.sticker?.images ?? [];

    return AttachmentSticker(
      title: 'Стикер',
      preview: sizes.length <= 1 ? null : sizes[1]?.url,
    );
  }
}
