import 'dart:core';

import 'package:vk_messenger_flutter/models/vk_conversation.dart' as VKConversation;

String serialize(Map<String, String> params) {
  String result = '';
  params.forEach((key, value) {
    result = '$result&$key=${Uri.encodeComponent(value)}';
  });
  return result;
}

String getAttachmentReplacer(VKConversation.Item item) {
  final attachments = item?.attachments;

  final attachmentType = attachments.length != 0 ? attachments[0]?.type : null;

  switch (attachmentType) {
    case VKConversation.AttachmentType.WALL: return 'Запись со стены';
    case VKConversation.AttachmentType.STICKER: return 'Стикер';
    case VKConversation.AttachmentType.PHOTO: return 'Фото';
    case VKConversation.AttachmentType.DOC: return 'Документ';
    case VKConversation.AttachmentType.GIFT: return 'Подарок';
    default: {
      final fwdMessages = item?.fwdMessages;
      if (fwdMessages != null) {
        return 'Пересланные сообщения';
      }
      return 'Вложение';
    }
  }
}
