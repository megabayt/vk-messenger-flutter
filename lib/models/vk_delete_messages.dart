// To parse this JSON data, do
//
//     final vkFriends = vkFriendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VkDeleteMessagesResponseBody vkFriendsFromJson(String str) => VkDeleteMessagesResponseBody.fromJson(json.decode(str));

String vkFriendsToJson(VkDeleteMessagesResponseBody data) => json.encode(data.toJson());

class VkDeleteMessagesResponseBody {
    VkDeleteMessagesResponseBody({
        @required this.response,
    });

    final Map<String, int> response;

    factory VkDeleteMessagesResponseBody.fromJson(Map<String, dynamic> json) => VkDeleteMessagesResponseBody(
        response: json["response"] == null ? null : Map<String, int>.from(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : response,
    };
}
