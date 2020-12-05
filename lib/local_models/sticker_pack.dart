import 'package:vk_messenger_flutter/local_models/sticker.dart';
import 'package:vk_messenger_flutter/vk_models/store_product.dart';

class StickerPack {
  StickerPack({
    this.id,
    this.stickers,
  });

  final int id;
  final List<Sticker> stickers;

  factory StickerPack.fromVkStoreProduct(VkStoreProduct vkStoreProduct) =>
      StickerPack(
        id: vkStoreProduct?.id,
        stickers: vkStoreProduct?.stickers == null
            ? null
            : vkStoreProduct.stickers.map(
                (element) => Sticker.fromVkSticker(element),
              ),
      );
}
