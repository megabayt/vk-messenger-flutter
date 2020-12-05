import 'package:vk_messenger_flutter/vk_models/profile.dart';

class VkFriendsResponse {
  VkFriendsResponse({
    this.count,
    this.items,
  });

  final int count;
  final List<VkProfile> items;

  factory VkFriendsResponse.fromMap(Map<String, dynamic> json) =>
      VkFriendsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null
            ? null
            : List<VkProfile>.from(
                json["items"].map((x) => VkProfile.fromMap(x))),
      );
}
