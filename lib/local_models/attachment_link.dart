import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_link.g.dart';

@CopyWith()
class AttachmentLink extends Attachment {
  AttachmentLink({
    String path,
    String url,
    String title = 'Ссылка',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentLink.fromVkAttachment(VkAttachment vkAttachment) {
    return AttachmentLink(
      title: 'Ссылка: ${vkAttachment?.link?.title ?? ''}',
      url: vkAttachment?.link?.url,
    );
  }
}
