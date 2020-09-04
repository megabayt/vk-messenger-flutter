// To parse this JSON data, do
//
//     final vkFriends = vkFriendsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:vk_messenger_flutter/models/profile.dart';

VkFriendsResponseBody vkFriendsFromJson(String str) => VkFriendsResponseBody.fromJson(json.decode(str));

String vkFriendsToJson(VkFriendsResponseBody data) => json.encode(data.toJson());

class VkFriendsResponseBody {
    VkFriendsResponseBody({
        @required this.response,
    });

    final VkFriendsResponse response;

    factory VkFriendsResponseBody.fromJson(Map<String, dynamic> json) => VkFriendsResponseBody(
        response: json["response"] == null ? null : VkFriendsResponse.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
    };
}

class VkFriendsResponse {
    VkFriendsResponse({
        @required this.count,
        @required this.items,
    });

    final int count;
    final List<Profile> items;

    factory VkFriendsResponse.fromJson(Map<String, dynamic> json) => VkFriendsResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Profile>.from(json["items"].map((x) => Profile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
    };
}
