import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment.dart';

part 'attachment_audio.g.dart';

@CopyWith()
class AttachmentAudio extends Attachment {
  final bool isContentRestricted;

  AttachmentAudio({
    String path,
    String url,
    String title = 'Аудио',
    String preview,
    bool isFetching,
    bool isContentRestricted = false,
  })  : isContentRestricted = isContentRestricted,
        super(
          path: path,
          url: url,
          title: title,
          preview: preview,
          isFetching: isFetching,
        );

  factory AttachmentAudio.fromVkAttachment(VkAttachment vkAttachment) {
    final artist = vkAttachment?.audio?.artist ?? '';
    final name = vkAttachment?.audio?.title ?? '';

    return AttachmentAudio(
      title: 'Аудио: $artist - $name',
      url: vkAttachment?.audio?.url,
      isContentRestricted: vkAttachment?.audio?.contentRestricted == 1,
    );
  }
}
