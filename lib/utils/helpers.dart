import 'dart:core';

// import 'package:vk_messenger_flutter/models/attachment.dart';
// import 'package:vk_messenger_flutter/models/local_attachment.dart';

String serialize(Map<String, String> params) {
  String result = '';
  params.forEach((key, value) {
    result = '$result&$key=${Uri.encodeComponent(value)}';
  });
  return result;
}

// String getAttachmentReplacer(Attachment attachment) {
//   final attachmentType = attachment?.type;

//   switch (attachmentType) {
//     case AttachmentType.DOC:
//       return 'Документ: ${attachment.doc?.title ?? ''}';
//     case AttachmentType.GIFT:
//       return 'Подарок';
//     case AttachmentType.LINK:
//       return 'Ссылка: ${attachment.link?.title ?? ''}';
//     case AttachmentType.PHOTO:
//       return 'Фото';
//     case AttachmentType.POLL:
//       return 'Голосование';
//     case AttachmentType.STICKER:
//       return 'Стикер';
//     case AttachmentType.STORY:
//       return 'История';
//     case AttachmentType.VIDEO:
//       return 'Видео: ${attachment?.video?.title ?? ''}';
//     case AttachmentType.AUDIO:
//       return 'Аудио: ${attachment.audio?.artist ?? ''} - ${attachment.audio?.title ?? ''}';
//     case AttachmentType.WALL:
//       return 'Запись со стены: ${attachment.wall?.text ?? ''}';
//     case AttachmentType.WALL_REPLY:
//       return 'Комментарий: ${attachment.wallReply?.text ?? ''}';
//     default:
//       return 'Вложение';
//   }
// }

// String getLocalAttachmentReplacer(LocalAttachment attachment) {
//   final path = attachment?.path ?? '';

//   if (path.indexOf('doc') != -1) {
//     return 'Документ';
//   }
//   if (path.indexOf('photo') != -1) {
//     return 'Фото';
//   }
//   if (path.indexOf('video') != -1) {
//     return 'Видео';
//   }
//   if (path.indexOf('audio') != -1) {
//     return 'Аудио';
//   }
//   return 'Вложение';
// }

void noop() {}
