import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_doc.g.dart';

@CopyWith()
class AttachmentDoc extends Attachment {
  AttachmentDoc({
    String path,
    String url,
    String title = 'Документ',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentDoc.fromVkAttachment(VkAttachment vkAttachment) {
    final ownerId = (vkAttachment?.doc?.ownerId ?? '').toString();
    final id = (vkAttachment?.doc?.id ?? '').toString();

    final sizes = vkAttachment?.doc?.preview?.photo?.sizes ?? [];

    return AttachmentDoc(
      title: 'Документ: ${vkAttachment?.doc?.title ?? ''}',
      preview: sizes.length == 0 ? null : sizes[0]?.url,
      url: 'https://vk.com/doc${ownerId}_$id',
    );
  }
}
