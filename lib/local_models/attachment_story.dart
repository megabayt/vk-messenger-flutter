import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_story.g.dart';

@CopyWith()
class AttachmentStory extends Attachment {
  final bool isExpired;

  AttachmentStory({
    String path,
    String url,
    String title = 'История',
    String preview,
    bool isFetching,
    bool isExpired,
  })  : isExpired = isExpired,
        super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentStory.fromVkAttachment(VkAttachment vkAttachment) {
    final ownerId = (vkAttachment?.story?.ownerId ?? '').toString();
    final id = (vkAttachment?.story?.id ?? '').toString();
    final sizes = vkAttachment?.story?.photo?.sizes ??
        vkAttachment?.story?.video?.image ??
        [];

    return AttachmentStory(
      title: 'История',
      url: 'https://vk.com/story${ownerId}_$id',
      preview: sizes.length == 0 ? null : sizes[0]?.url,
      isExpired: vkAttachment?.story?.isExpired == true,
    );
  }
}
