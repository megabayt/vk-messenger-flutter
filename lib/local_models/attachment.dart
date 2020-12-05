import 'package:vk_messenger_flutter/vk_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';

class Attachment {
  Attachment({
    this.type,
    this.url,
    this.title,
    this.preview,
  });

  final VkAttachmentType type;
  final String url;
  final String title;
  final String preview;

  factory Attachment.fromVkAttachment(VkAttachment vkAttachment) {
    final type = vkAttachment.type;

    String url;
    String title;
    String preview;

    switch (type) {
      case VkAttachmentType.DOC:
        title = 'Документ: ${vkAttachment?.doc?.title ?? ''}';

        final ownerId = (vkAttachment?.doc?.ownerId ?? '').toString();
        final id = (vkAttachment?.doc?.id ?? '').toString();

        url = 'https://vk.com/doc${ownerId}_$id';
        break;
      case VkAttachmentType.GIFT:
        title = 'Подарок';
        break;
      case VkAttachmentType.LINK:
        title = 'Ссылка: ${vkAttachment?.link?.title ?? ''}';

        url = vkAttachment?.link?.url;
        break;
      case VkAttachmentType.PHOTO:
        title = 'Фото';

        final sizes = vkAttachment?.photo?.sizes ?? [];
        preview = sizes[0]?.url;

        url = sizes[sizes.length - 1]?.url;
        break;
      case VkAttachmentType.POLL:
        title = 'Голосование';
        break;
      case VkAttachmentType.STICKER:
        title = 'Стикер';

        final sizes = vkAttachment?.sticker?.images ?? [];
        preview = sizes[1]?.url;
        break;
      case VkAttachmentType.STORY:
        title = 'История';

        final ownerId = (vkAttachment?.story?.ownerId ?? '').toString();
        final id = (vkAttachment?.story?.id ?? '').toString();
        url = 'https://vk.com/story${ownerId}_$id';

        final sizes = vkAttachment?.story?.photo?.sizes ??
            vkAttachment?.story?.video?.image ??
            [];
        preview = sizes[0]?.url;
        break;
      case VkAttachmentType.VIDEO:
        title = 'Видео: ${vkAttachment?.video?.title ?? ''}';

        final ownerId = (vkAttachment?.video?.ownerId ?? '').toString();
        final id = (vkAttachment?.video?.id ?? '').toString();
        url = 'https://vk.com/video${ownerId}_$id';

        final sizes = vkAttachment?.video?.image ?? [];
        preview = sizes[0]?.url;
        break;
      case VkAttachmentType.AUDIO:
        final artist = vkAttachment?.audio?.artist ?? '';
        final name = vkAttachment?.audio?.title ?? '';
        title = 'Аудио: $artist - $name';

        url = vkAttachment?.audio?.url;
        break;
      case VkAttachmentType.WALL:
        title = 'Запись со стены: ${vkAttachment?.wall?.text ?? ''}';

        final fromId = vkAttachment?.wall?.fromId;
        final id = vkAttachment?.wall?.id;
        url = 'https://vk.com/wall${fromId}_$id';
        break;
      case VkAttachmentType.WALL_REPLY:
        title = 'Комментарий: ${vkAttachment?.wallReply?.text ?? ''}';

        final ownerId = vkAttachment?.wallReply?.ownerId;
        final postId = vkAttachment?.wallReply?.postId;
        final id = vkAttachment?.wallReply?.id;

        url = 'https://vk.com/wall${ownerId}_$postId?reply=$id';
        break;
      default:
        title = 'Вложение';
        break;
    }
    return Attachment(
      type: type,
      title: title,
      url: url,
      preview: preview,
    );
  }

  Attachment copyWith({
    VkAttachmentType type,
    String url,
    String title,
    String preview,
  }) =>
      Attachment(
        type: type ?? this.type,
        url: url ?? this.url,
        title: title ?? this.title,
        preview: preview ?? this.preview,
      );
}
