// To parse this JSON data, do
//
//     final vkFriends = vkFriendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:vk_messenger_flutter/models/vk_error.dart';

VkDeleteMessagesResponseBody vkFriendsFromJson(String str) =>
    VkDeleteMessagesResponseBody.fromJson(json.decode(str));

String vkFriendsToJson(VkDeleteMessagesResponseBody data) =>
    json.encode(data.toJson());

class VkDeleteMessagesResponseBody {
  VkDeleteMessagesResponseBody({
    @required this.response,
    this.error,
  });

  final Map<String, int> response;
  final VkError error;

  factory VkDeleteMessagesResponseBody.fromJson(Map<String, dynamic> json) =>
      VkDeleteMessagesResponseBody(
        response: json["response"] == null
            ? null
            : Map<String, int>.from(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response,
        "error": error == null ? null : error.toJson(),
      };
}
