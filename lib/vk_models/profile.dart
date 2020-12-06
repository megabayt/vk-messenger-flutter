import 'package:vk_messenger_flutter/vk_models/online_info.dart';

class VkProfile {
  VkProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.photo50,
    this.photo100,
    this.photo200,
    this.online,
    this.onlineInfo,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String name;
  final String photo50;
  final String photo100;
  final String photo200;
  final int online;
  final VkOnlineInfo onlineInfo;

  factory VkProfile.fromMap(Map<String, dynamic> json) => VkProfile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        name: json["name"] == null ? null : json["name"],
        photo50: json["photo_50"] == null ? null : json["photo_50"],
        photo100: json["photo_100"] == null ? null : json["photo_100"],
        photo200: json["photo_200"] == null ? null : json["photo_200"],
        online: json["online"] == null ? null : json["online"],
        onlineInfo: json["online_info"] == null
            ? null
            : VkOnlineInfo.fromMap(json["online_info"]),
      );
}
