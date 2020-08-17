import 'dart:core';

import 'package:vk_messenger_flutter/models/vk_conversation.dart'
    as VKConversation;

String serialize(Map<String, String> params) {
  String result = '';
  params.forEach((key, value) {
    result = '$result&$key=${Uri.encodeComponent(value)}';
  });
  return result;
}

String getAttachmentReplacer(VKConversation.ItemAttachment attachment) {
  final attachmentType = attachment?.type;

  switch (attachmentType) {
    case VKConversation.AttachmentType.DOC:
      return 'Документ: ${attachment.doc?.title ?? ''}';
    case VKConversation.AttachmentType.GIFT:
      return 'Подарок';
    case VKConversation.AttachmentType.LINK:
      return 'Ссылка: ${attachment.link?.title ?? ''}';
    case VKConversation.AttachmentType.PHOTO:
      return 'Фото';
    case VKConversation.AttachmentType.POLL:
      return 'Голосование';
    case VKConversation.AttachmentType.STICKER:
      return 'Стикер';
    case VKConversation.AttachmentType.STORY:
      return 'История';
    case VKConversation.AttachmentType.VIDEO:
      return 'Видео: ${attachment?.video?.title ?? ''}';
    case VKConversation.AttachmentType.AUDIO:
      return 'Аудио: ${attachment.audio?.artist ?? ''} - ${attachment.audio?.title ?? ''}';
    case VKConversation.AttachmentType.WALL:
      return 'Запись со стены: ${attachment.wall?.text ?? ''}';
    case VKConversation.AttachmentType.WALL_REPLY:
      return 'Комментарий: ${attachment.wallReply?.text ?? ''}';
    default:
      return 'Вложение';
  }
}
