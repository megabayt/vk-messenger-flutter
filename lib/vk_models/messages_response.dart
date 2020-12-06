import 'package:vk_messenger_flutter/vk_models/message.dart';

class VkMessagesResponse {
  VkMessagesResponse({
    this.count,
    this.items,
  });

  final int count;
  final List<VkMessage> items;

  factory VkMessagesResponse.fromMap(Map<String, dynamic> json) =>
      VkMessagesResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkMessage>.from(
                json["items"].map((x) => VkMessage.fromMap(x))),
      );
}
