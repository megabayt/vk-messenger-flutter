import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_wall_reply.g.dart';

@CopyWith()
class AttachmentWallReply extends Attachment {
  AttachmentWallReply({
    String path,
    String url,
    String title = 'Комментарий',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentWallReply.fromVkAttachment(VkAttachment vkAttachment) {
    final ownerId = vkAttachment?.wallReply?.ownerId;
    final postId = vkAttachment?.wallReply?.postId;
    final id = vkAttachment?.wallReply?.id;

    return AttachmentWallReply(
      title: 'Комментарий: ${vkAttachment?.wallReply?.text ?? ''}',
      url: 'https://vk.com/wall${ownerId}_$postId?reply=$id',
    );
  }
}
