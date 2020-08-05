import 'dart:core';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' as VKConversations;

String serialize(Map<String, String> params) {
  String result = '';
  params.forEach((key, value) {
    result = '$result&$key=${Uri.encodeComponent(value)}';
  });
  return result;
}

String getAttachmentReplacer(VKConversations.Item item) {
  final attachments = item?.lastMessage?.attachments;

  final attachmentType = attachments.length != 0 ? attachments[0]?.type : null;

  switch (attachmentType) {
    case 'wall': return 'Запись со стены';
    case 'sticker': return 'Стикер';
    case 'photo': return 'Фото';
    case 'doc': return 'Документ';
    case 'gift': return 'Подарок';
    default: {
      final fwdMessages = item?.lastMessage?.fwdMessages;
      if (fwdMessages != null) {
        return 'Пересланные сообщения';
      }
      return 'Вложение';
    }
  }
}
