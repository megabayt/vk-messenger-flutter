import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_poll.g.dart';

@CopyWith()
class AttachmentPoll extends Attachment {
  AttachmentPoll({
    String path,
    String url,
    String title = 'Голосование',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentPoll.fromVkAttachment(VkAttachment vkAttachment) {
    return AttachmentPoll(
      title: 'Голосование',
    );
  }
}
