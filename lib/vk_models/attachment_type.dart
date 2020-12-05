import 'package:vk_messenger_flutter/utils/enum_values.dart';

enum VkAttachmentType {
  PHOTO,
  LINK,
  WALL,
  STICKER,
  DOC,
  WALL_REPLY,
  VIDEO,
  STORY,
  POLL,
  GIFT,
  AUDIO
}

final vkAttachmentTypeValues = EnumValues({
  "doc": VkAttachmentType.DOC,
  "link": VkAttachmentType.LINK,
  "photo": VkAttachmentType.PHOTO,
  "poll": VkAttachmentType.POLL,
  "sticker": VkAttachmentType.STICKER,
  "story": VkAttachmentType.STORY,
  "video": VkAttachmentType.VIDEO,
  "wall": VkAttachmentType.WALL,
  "wall_reply": VkAttachmentType.WALL_REPLY,
  "gift": VkAttachmentType.GIFT,
  "audio": VkAttachmentType.AUDIO,
});
