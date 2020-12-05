import 'package:vk_messenger_flutter/vk_models/sticker.dart';

class Sticker {
  Sticker({
    this.id,
    this.url,
  });

  final int id;
  final String url;

  factory Sticker.fromVkSticker(VkSticker vkSticker) => Sticker(
        id: vkSticker?.stickerId,
        url: vkSticker?.images[1]?.url,
      );
}
