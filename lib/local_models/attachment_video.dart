import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_video.g.dart';

@CopyWith()
class AttachmentVideo extends Attachment {
  AttachmentVideo({
    String path,
    String url,
    String title = 'Видео',
    String preview,
    bool isFetching,
  }) : super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentVideo.fromVkAttachment(VkAttachment vkAttachment) {
    final ownerId = (vkAttachment?.video?.ownerId ?? '').toString();
    final id = (vkAttachment?.video?.id ?? '').toString();
    final sizes = vkAttachment?.video?.image ?? [];

    return AttachmentVideo(
      title: 'Видео: ${vkAttachment?.video?.title ?? ''}',
      url: 'https://vk.com/video${ownerId}_$id',
      preview: sizes.length == 0 ? null : sizes[0]?.url,
    );
  }
}
