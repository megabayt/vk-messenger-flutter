// To parse this JSON data, do
//
//     final vkFriends = vkFriendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:vk_messenger_flutter/models/message.dart';

VkMessagesResponseBody vkFriendsFromJson(String str) => VkMessagesResponseBody.fromJson(json.decode(str));

String vkFriendsToJson(VkMessagesResponseBody data) => json.encode(data.toJson());

class VkMessagesResponseBody {
    VkMessagesResponseBody({
        @required this.response,
    });

    final VkMessagesResponse response;

    factory VkMessagesResponseBody.fromJson(Map<String, dynamic> json) => VkMessagesResponseBody(
        response: json["response"] == null ? null : VkMessagesResponse.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
    };
}

class VkMessagesResponse {
    VkMessagesResponse({
        @required this.count,
        @required this.items,
    });

    final int count;
    final List<Message> items;

    factory VkMessagesResponse.fromJson(Map<String, dynamic> json) => VkMessagesResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Message>.from(json["items"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    };
}
