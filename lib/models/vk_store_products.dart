// To parse this JSON data, do
//
//     final storeProducts = storeProductsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:vk_messenger_flutter/models/store_product.dart';
import 'package:vk_messenger_flutter/models/vk_error.dart';

VkStoreProducts storeProductsFromJson(String str) =>
    VkStoreProducts.fromJson(json.decode(str));

String storeProductsToJson(VkStoreProducts data) => json.encode(data.toJson());

class VkStoreProducts {
  VkStoreProducts({
    @required this.response,
    this.error,
  });

  final VkStoreProductsResponse response;
  final VkError error;

  factory VkStoreProducts.fromJson(Map<String, dynamic> json) => VkStoreProducts(
        response: json["response"] == null
            ? null
            : VkStoreProductsResponse.fromJson(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}

class VkStoreProductsResponse {
  VkStoreProductsResponse({
    @required this.count,
    @required this.items,
  });

  final int count;
  final List<StoreProduct> items;

  factory VkStoreProductsResponse.fromJson(Map<String, dynamic> json) =>
      VkStoreProductsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<StoreProduct>.from(
                json["items"].map((x) => StoreProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
