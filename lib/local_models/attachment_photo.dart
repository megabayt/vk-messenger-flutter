import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_photo.g.dart';

@CopyWith()
class AttachmentPhoto extends Attachment {
  AttachmentPhoto({
    String path,
    String url,
    String title = 'Фото',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentPhoto.fromVkAttachment(VkAttachment vkAttachment) {
    final sizes = vkAttachment?.photo?.sizes ?? [];

    return AttachmentPhoto(
      title: 'Фото',
      preview: sizes.length == 0 ? null : sizes[0]?.url,
      url: sizes.length == 0 ? null : sizes[sizes.length - 1]?.url,
    );
  }
}
