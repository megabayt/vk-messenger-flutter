import 'package:vk_messenger_flutter/vk_models/store_product.dart';

class VkStoreProductsResponse {
  VkStoreProductsResponse({
    this.count,
    this.items,
  });

  final int count;
  final List<VkStoreProduct> items;

  factory VkStoreProductsResponse.fromMap(Map<String, dynamic> json) =>
      VkStoreProductsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkStoreProduct>.from(
                json["items"].map((x) => VkStoreProduct.fromMap(x))),
      );
}
