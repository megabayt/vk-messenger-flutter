import 'package:vk_messenger_flutter/utils/enum_values.dart';
import 'package:map_path/map_path.dart';

class Attachment {
  Attachment({
    this.type,
    this.url,
    this.title,
    this.preview,
  });

  final AttachmentType type;
  final String url;
  final String title;
  final String preview;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    final type = json == null || json['type'] == null
        ? null
        : attachmentTypeValues.map[json['type']];

    String url;
    String title;
    String preview;

    switch (type) {
      case AttachmentType.DOC:
        title = 'Документ: ${mapPath(json, ['doc', 'title']) ?? ''}';

        final ownerId = (mapPath(json, ['doc', 'owner_id']) ?? '').toString();
        final id = (mapPath(json, ['doc', 'id']) ?? '').toString();

        url = 'https://vk.com/doc${ownerId}_${id}';
        break;
      case AttachmentType.GIFT:
        title = 'Подарок';
        break;
      case AttachmentType.LINK:
        title = 'Ссылка: ${mapPath(json, ['link', 'title']) ?? ''}';

        url = mapPath(json, ['link', 'url']);
        break;
      case AttachmentType.PHOTO:
        title = 'Фото';

        final sizes = mapPath(json, ['photo', 'sizes']) ?? [];
        preview = mapPath(sizes, [0, 'url']);

        url = mapPath(sizes, [sizes.length - 1, 'url']);
        break;
      case AttachmentType.POLL:
        title = 'Голосование';
        break;
      case AttachmentType.STICKER:
        title = 'Стикер';

        final sizes = mapPath(json, ['sticker', 'images']) ?? [];
        preview = mapPath(sizes, [1, 'url']);
        break;
      case AttachmentType.STORY:
        title = 'История';

        final ownerId = (mapPath(json, ['story', 'owner_id']) ?? '').toString();
        final id = (mapPath(json, ['story', 'id']) ?? '').toString();
        url = 'https://vk.com/story${ownerId}_$id';

        final sizes = mapPath(json, ['story', 'photo', 'sizes']) ??
            mapPath(json, ['story', 'video', 'image']) ??
            [];
        preview = mapPath(sizes, [0, 'url']);
        break;
      case AttachmentType.VIDEO:
        title = 'Видео: ${mapPath(json, ['video', 'title']) ?? ''}';

        final ownerId = (mapPath(json, ['video', 'owner_id']) ?? '').toString();
        final id = (mapPath(json, ['video', 'id']) ?? '').toString();
        url = 'https://vk.com/video${ownerId}_$id';

        final sizes = mapPath(json, ['video', 'image']) ?? [];
        preview = mapPath(sizes, [0, 'url']);
        break;
      case AttachmentType.AUDIO:
        final artist = mapPath(json, ['audio', 'artist']) ?? '';
        final name = mapPath(json, ['audio', 'title']) ?? '';
        title = 'Аудио: $artist - $name';

        url = mapPath(json, ['audio', 'url']);
        break;
      case AttachmentType.WALL:
        title = 'Запись со стены: ${mapPath(json, ['wall', 'text']) ?? ''}';

        final fromId = mapPath(json, ['wall', 'from_id']);
        final id = mapPath(json, ['wall', 'id']);
        url = 'https://vk.com/wall${fromId}_$id';
        break;
      case AttachmentType.WALL_REPLY:
        title = 'Комментарий: ${mapPath(json, ['wall_reply', 'text']) ?? ''}';

        final ownerId = mapPath(json, ['wall', 'owner_id']);
        final postId = mapPath(json, ['wall', 'post_id']);
        final id = mapPath(json, ['wall', 'id']);

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
    AttachmentType type,
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

enum AttachmentType {
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

final attachmentTypeValues = EnumValues({
  "doc": AttachmentType.DOC,
  "link": AttachmentType.LINK,
  "photo": AttachmentType.PHOTO,
  "poll": AttachmentType.POLL,
  "sticker": AttachmentType.STICKER,
  "story": AttachmentType.STORY,
  "video": AttachmentType.VIDEO,
  "wall": AttachmentType.WALL,
  "wall_reply": AttachmentType.WALL_REPLY,
  "gift": AttachmentType.GIFT,
  "audio": AttachmentType.AUDIO,
});
