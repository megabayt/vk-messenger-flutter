import 'dart:convert';

import 'package:vk_messenger_flutter/models/group.dart';
import 'package:vk_messenger_flutter/models/profile.dart';
import 'package:vk_messenger_flutter/models/conversation.dart';
import 'package:vk_messenger_flutter/models/message.dart';

class VkConversationResponseBody {
    VkConversationResponseBody({
        this.response,
    });

    final VkConversationResponse response;

    factory VkConversationResponseBody.fromRawJson(String str) => VkConversationResponseBody.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VkConversationResponseBody.fromJson(Map<String, dynamic> json) => VkConversationResponseBody(
        response: json["response"] == null ? null : VkConversationResponse.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
    };
}

class VkConversationResponse {
    VkConversationResponse({
        this.count,
        this.items,
        this.conversations,
        this.profiles,
        this.groups,
    });

    final int count;
    final List<Message> items;
    final List<Conversation> conversations;
    final List<Profile> profiles;
    final List<Group> groups;

    factory VkConversationResponse.fromRawJson(String str) => VkConversationResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VkConversationResponse.fromJson(Map<String, dynamic> json) => VkConversationResponse(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Message>.from(json["items"].map((x) => Message.fromJson(x))),
        conversations: json["conversations"] == null ? null : List<Conversation>.from(json["conversations"].map((x) => Conversation.fromJson(x))),
        profiles: json["profiles"] == null ? null : List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "conversations": conversations == null ? null : List<dynamic>.from(conversations.map((x) => x.toJson())),
        "profiles": profiles == null ? null : List<dynamic>.from(profiles.map((x) => x.toJson())),
        "groups": groups == null ? null : List<dynamic>.from(groups.map((x) => x.toJson())),
    };
}
