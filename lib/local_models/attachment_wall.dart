import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_wall.g.dart';

@CopyWith()
class AttachmentWall extends Attachment {
  AttachmentWall({
    String path,
    String url,
    String title = 'Запись со стены',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentWall.fromVkAttachment(VkAttachment vkAttachment) {
    final fromId = vkAttachment?.wall?.fromId;
    final id = vkAttachment?.wall?.id;

    return AttachmentWall(
      title: 'Запись со стены: ${vkAttachment?.wall?.text ?? ''}',
      url: 'https://vk.com/wall${fromId}_$id',
    );
  }
}
