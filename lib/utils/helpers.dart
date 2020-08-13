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
      return 'Документ';
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
      return 'Видео';
    case VKConversation.AttachmentType.WALL:
      return 'Запись со стены';
    case VKConversation.AttachmentType.WALL_REPLY:
      return 'Комментарий';
    default:
      return 'Вложение';
  }
}
