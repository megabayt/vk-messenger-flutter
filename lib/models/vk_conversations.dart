// To parse this JSON data, do
//
//     final vkConversations = vkConversationsFromJson(jsonString);

import 'dart:convert';

import 'package:vk_messenger_flutter/models/vk_conversation.dart' as VKConversation;

class VkConversations {
    VkConversations({
        this.response,
    });

    final Response response;

    factory VkConversations.fromRawJson(String str) => VkConversations.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VkConversations.fromJson(Map<String, dynamic> json) => VkConversations(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
    };
}

class Response {
    Response({
        this.count,
        this.items,
        this.unreadCount,
        this.profiles,
        this.groups,
        this.emails,
    });

    final int count;
    final List<Item> items;
    final int unreadCount;
    final List<Profile> profiles;
    final List<Group> groups;
    final List<Email> emails;

    factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
        profiles: json["profiles"] == null ? null : List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
        "unread_count": unreadCount == null ? null : unreadCount,
        "profiles": profiles == null ? null : List<dynamic>.from(profiles.map((x) => x.toJson())),
        "groups": groups == null ? null : List<dynamic>.from(groups.map((x) => x.toJson())),
        "emails": emails == null ? null : List<dynamic>.from(emails.map((x) => x.toJson())),
    };
}

class Email {
    Email({
        this.id,
        this.address,
    });

    final int id;
    final String address;

    factory Email.fromRawJson(String str) => Email.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Email.fromJson(Map<String, dynamic> json) => Email(
        id: json["id"] == null ? null : json["id"],
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "address": address == null ? null : address,
    };
}

class Group {
    Group({
        this.id,
        this.name,
        this.screenName,
        this.isClosed,
        this.type,
        this.isAdmin,
        this.isMember,
        this.isAdvertiser,
        this.photo50,
        this.photo100,
        this.photo200,
    });

    final int id;
    final String name;
    final String screenName;
    final int isClosed;
    final GroupType type;
    final int isAdmin;
    final int isMember;
    final int isAdvertiser;
    final String photo50;
    final String photo100;
    final String photo200;

    factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        screenName: json["screen_name"] == null ? null : json["screen_name"],
        isClosed: json["is_closed"] == null ? null : json["is_closed"],
        type: json["type"] == null ? null : groupTypeValues.map[json["type"]],
        isAdmin: json["is_admin"] == null ? null : json["is_admin"],
        isMember: json["is_member"] == null ? null : json["is_member"],
        isAdvertiser: json["is_advertiser"] == null ? null : json["is_advertiser"],
        photo50: json["photo_50"] == null ? null : json["photo_50"],
        photo100: json["photo_100"] == null ? null : json["photo_100"],
        photo200: json["photo_200"] == null ? null : json["photo_200"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "screen_name": screenName == null ? null : screenName,
        "is_closed": isClosed == null ? null : isClosed,
        "type": type == null ? null : groupTypeValues.reverse[type],
        "is_admin": isAdmin == null ? null : isAdmin,
        "is_member": isMember == null ? null : isMember,
        "is_advertiser": isAdvertiser == null ? null : isAdvertiser,
        "photo_50": photo50 == null ? null : photo50,
        "photo_100": photo100 == null ? null : photo100,
        "photo_200": photo200 == null ? null : photo200,
    };
}

enum GroupType { PAGE, GROUP, EVENT }

final groupTypeValues = EnumValues({
    "event": GroupType.EVENT,
    "group": GroupType.GROUP,
    "page": GroupType.PAGE
});

class Item {
    Item({
        this.conversation,
        this.lastMessage,
    });

    final Conversation conversation;
    final VKConversation.Item lastMessage;

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
        lastMessage: json["last_message"] == null ? null : VKConversation.Item.fromJson(json["last_message"])
    );

    Map<String, dynamic> toJson() => {
        "conversation": conversation == null ? null : conversation.toJson(),
        "last_message": lastMessage == null ? null : lastMessage.toJson(),
    };
}

class Conversation {
    Conversation({
        this.peer,
        this.lastMessageId,
        this.inRead,
        this.outRead,
        this.sortId,
        this.unreadCount,
        this.isMarkedUnread,
        this.important,
        this.canWrite,
        this.chatSettings,
        this.currentKeyboard,
        this.pushSettings,
    });

    final Peer peer;
    final int lastMessageId;
    final int inRead;
    final int outRead;
    final SortId sortId;
    final int unreadCount;
    final bool isMarkedUnread;
    final bool important;
    final CanWrite canWrite;
    final ChatSettings chatSettings;
    final CurrentKeyboard currentKeyboard;
    final PushSettings pushSettings;

    factory Conversation.fromRawJson(String str) => Conversation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        peer: json["peer"] == null ? null : Peer.fromJson(json["peer"]),
        lastMessageId: json["last_message_id"] == null ? null : json["last_message_id"],
        inRead: json["in_read"] == null ? null : json["in_read"],
        outRead: json["out_read"] == null ? null : json["out_read"],
        sortId: json["sort_id"] == null ? null : SortId.fromJson(json["sort_id"]),
        unreadCount: json["unread_count"] == null ? null : json["unread_count"],
        isMarkedUnread: json["is_marked_unread"] == null ? null : json["is_marked_unread"],
        important: json["important"] == null ? null : json["important"],
        canWrite: json["can_write"] == null ? null : CanWrite.fromJson(json["can_write"]),
        chatSettings: json["chat_settings"] == null ? null : ChatSettings.fromJson(json["chat_settings"]),
        currentKeyboard: json["current_keyboard"] == null ? null : CurrentKeyboard.fromJson(json["current_keyboard"]),
        pushSettings: json["push_settings"] == null ? null : PushSettings.fromJson(json["push_settings"]),
    );

    Map<String, dynamic> toJson() => {
        "peer": peer == null ? null : peer.toJson(),
        "last_message_id": lastMessageId == null ? null : lastMessageId,
        "in_read": inRead == null ? null : inRead,
        "out_read": outRead == null ? null : outRead,
        "sort_id": sortId == null ? null : sortId.toJson(),
        "unread_count": unreadCount == null ? null : unreadCount,
        "is_marked_unread": isMarkedUnread == null ? null : isMarkedUnread,
        "important": important == null ? null : important,
        "can_write": canWrite == null ? null : canWrite.toJson(),
        "chat_settings": chatSettings == null ? null : chatSettings.toJson(),
        "current_keyboard": currentKeyboard == null ? null : currentKeyboard.toJson(),
        "push_settings": pushSettings == null ? null : pushSettings.toJson(),
    };
}

class CanWrite {
    CanWrite({
        this.allowed,
        this.reason,
    });

    final bool allowed;
    final int reason;

    factory CanWrite.fromRawJson(String str) => CanWrite.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CanWrite.fromJson(Map<String, dynamic> json) => CanWrite(
        allowed: json["allowed"] == null ? null : json["allowed"],
        reason: json["reason"] == null ? null : json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "allowed": allowed == null ? null : allowed,
        "reason": reason == null ? null : reason,
    };
}

class ChatSettings {
    ChatSettings({
        this.ownerId,
        this.title,
        this.state,
        this.acl,
        this.membersCount,
        this.activeIds,
        this.isGroupChannel,
        this.permissions,
        this.isDisappearing,
        this.isService,
        this.pinnedMessage,
    });

    final int ownerId;
    final String title;
    final State state;
    final Acl acl;
    final int membersCount;
    final List<int> activeIds;
    final bool isGroupChannel;
    final Permissions permissions;
    final bool isDisappearing;
    final bool isService;
    final PinnedMessage pinnedMessage;

    factory ChatSettings.fromRawJson(String str) => ChatSettings.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChatSettings.fromJson(Map<String, dynamic> json) => ChatSettings(
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        acl: json["acl"] == null ? null : Acl.fromJson(json["acl"]),
        membersCount: json["members_count"] == null ? null : json["members_count"],
        activeIds: json["active_ids"] == null ? null : List<int>.from(json["active_ids"].map((x) => x)),
        isGroupChannel: json["is_group_channel"] == null ? null : json["is_group_channel"],
        permissions: json["permissions"] == null ? null : Permissions.fromJson(json["permissions"]),
        isDisappearing: json["is_disappearing"] == null ? null : json["is_disappearing"],
        isService: json["is_service"] == null ? null : json["is_service"],
        pinnedMessage: json["pinned_message"] == null ? null : PinnedMessage.fromJson(json["pinned_message"]),
    );

    Map<String, dynamic> toJson() => {
        "owner_id": ownerId == null ? null : ownerId,
        "title": title == null ? null : title,
        "state": state == null ? null : stateValues.reverse[state],
        "acl": acl == null ? null : acl.toJson(),
        "members_count": membersCount == null ? null : membersCount,
        "active_ids": activeIds == null ? null : List<dynamic>.from(activeIds.map((x) => x)),
        "is_group_channel": isGroupChannel == null ? null : isGroupChannel,
        "permissions": permissions == null ? null : permissions.toJson(),
        "is_disappearing": isDisappearing == null ? null : isDisappearing,
        "is_service": isService == null ? null : isService,
        "pinned_message": pinnedMessage == null ? null : pinnedMessage.toJson(),
    };
}

class Acl {
    Acl({
        this.canChangeInfo,
        this.canChangeInviteLink,
        this.canChangePin,
        this.canInvite,
        this.canPromoteUsers,
        this.canSeeInviteLink,
        this.canModerate,
        this.canCopyChat,
        this.canCall,
        this.canUseMassMentions,
        this.canChangeServiceType,
    });

    final bool canChangeInfo;
    final bool canChangeInviteLink;
    final bool canChangePin;
    final bool canInvite;
    final bool canPromoteUsers;
    final bool canSeeInviteLink;
    final bool canModerate;
    final bool canCopyChat;
    final bool canCall;
    final bool canUseMassMentions;
    final bool canChangeServiceType;

    factory Acl.fromRawJson(String str) => Acl.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Acl.fromJson(Map<String, dynamic> json) => Acl(
        canChangeInfo: json["can_change_info"] == null ? null : json["can_change_info"],
        canChangeInviteLink: json["can_change_invite_link"] == null ? null : json["can_change_invite_link"],
        canChangePin: json["can_change_pin"] == null ? null : json["can_change_pin"],
        canInvite: json["can_invite"] == null ? null : json["can_invite"],
        canPromoteUsers: json["can_promote_users"] == null ? null : json["can_promote_users"],
        canSeeInviteLink: json["can_see_invite_link"] == null ? null : json["can_see_invite_link"],
        canModerate: json["can_moderate"] == null ? null : json["can_moderate"],
        canCopyChat: json["can_copy_chat"] == null ? null : json["can_copy_chat"],
        canCall: json["can_call"] == null ? null : json["can_call"],
        canUseMassMentions: json["can_use_mass_mentions"] == null ? null : json["can_use_mass_mentions"],
        canChangeServiceType: json["can_change_service_type"] == null ? null : json["can_change_service_type"],
    );

    Map<String, dynamic> toJson() => {
        "can_change_info": canChangeInfo == null ? null : canChangeInfo,
        "can_change_invite_link": canChangeInviteLink == null ? null : canChangeInviteLink,
        "can_change_pin": canChangePin == null ? null : canChangePin,
        "can_invite": canInvite == null ? null : canInvite,
        "can_promote_users": canPromoteUsers == null ? null : canPromoteUsers,
        "can_see_invite_link": canSeeInviteLink == null ? null : canSeeInviteLink,
        "can_moderate": canModerate == null ? null : canModerate,
        "can_copy_chat": canCopyChat == null ? null : canCopyChat,
        "can_call": canCall == null ? null : canCall,
        "can_use_mass_mentions": canUseMassMentions == null ? null : canUseMassMentions,
        "can_change_service_type": canChangeServiceType == null ? null : canChangeServiceType,
    };
}

class Permissions {
    Permissions({
        this.invite,
        this.changeInfo,
        this.changePin,
        this.useMassMentions,
        this.seeInviteLink,
        this.call,
        this.changeAdmins,
    });

    final String invite;
    final String changeInfo;
    final String changePin;
    final String useMassMentions;
    final String seeInviteLink;
    final String call;
    final String changeAdmins;

    factory Permissions.fromRawJson(String str) => Permissions.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
        invite: json["invite"] == null ? null : json["invite"],
        changeInfo: json["change_info"] == null ? null : json["change_info"],
        changePin: json["change_pin"] == null ? null : json["change_pin"],
        useMassMentions: json["use_mass_mentions"] == null ? null : json["use_mass_mentions"],
        seeInviteLink: json["see_invite_link"] == null ? null : json["see_invite_link"],
        call: json["call"] == null ? null : json["call"],
        changeAdmins: json["change_admins"] == null ? null : json["change_admins"],
    );

    Map<String, dynamic> toJson() => {
        "invite": invite == null ? null : invite,
        "change_info": changeInfo == null ? null : changeInfo,
        "change_pin": changePin == null ? null : changePin,
        "use_mass_mentions": useMassMentions == null ? null : useMassMentions,
        "see_invite_link": seeInviteLink == null ? null : seeInviteLink,
        "call": call == null ? null : call,
        "change_admins": changeAdmins == null ? null : changeAdmins,
    };
}

class PinnedMessage {
    PinnedMessage({
        this.id,
        this.date,
        this.fromId,
        this.peerId,
        this.text,
        this.attachments,
        this.conversationMessageId,
    });

    final int id;
    final int date;
    final int fromId;
    final int peerId;
    final String text;
    final List<dynamic> attachments;
    final int conversationMessageId;

    factory PinnedMessage.fromRawJson(String str) => PinnedMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PinnedMessage.fromJson(Map<String, dynamic> json) => PinnedMessage(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        attachments: json["attachments"] == null ? null : List<dynamic>.from(json["attachments"].map((x) => x)),
        conversationMessageId: json["conversation_message_id"] == null ? null : json["conversation_message_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "from_id": fromId == null ? null : fromId,
        "peer_id": peerId == null ? null : peerId,
        "text": text == null ? null : text,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x)),
        "conversation_message_id": conversationMessageId == null ? null : conversationMessageId,
    };
}

enum State { IN, LEFT, KICKED }

final stateValues = EnumValues({
    "in": State.IN,
    "kicked": State.KICKED,
    "left": State.LEFT
});

class CurrentKeyboard {
    CurrentKeyboard({
        this.oneTime,
        this.authorId,
        this.buttons,
        this.inline,
    });

    final bool oneTime;
    final int authorId;
    final List<List<Button>> buttons;
    final bool inline;

    factory CurrentKeyboard.fromRawJson(String str) => CurrentKeyboard.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CurrentKeyboard.fromJson(Map<String, dynamic> json) => CurrentKeyboard(
        oneTime: json["one_time"] == null ? null : json["one_time"],
        authorId: json["author_id"] == null ? null : json["author_id"],
        buttons: json["buttons"] == null ? null : List<List<Button>>.from(json["buttons"].map((x) => List<Button>.from(x.map((x) => Button.fromJson(x))))),
        inline: json["inline"] == null ? null : json["inline"],
    );

    Map<String, dynamic> toJson() => {
        "one_time": oneTime == null ? null : oneTime,
        "author_id": authorId == null ? null : authorId,
        "buttons": buttons == null ? null : List<dynamic>.from(buttons.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "inline": inline == null ? null : inline,
    };
}

class Button {
    Button({
        this.action,
        this.color,
    });

    final Action action;
    final Color color;

    factory Button.fromRawJson(String str) => Button.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Button.fromJson(Map<String, dynamic> json) => Button(
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
        color: json["color"] == null ? null : colorValues.map[json["color"]],
    );

    Map<String, dynamic> toJson() => {
        "action": action == null ? null : action.toJson(),
        "color": color == null ? null : colorValues.reverse[color],
    };
}

class Action {
    Action({
        this.type,
        this.label,
        this.payload,
        this.appId,
        this.hash,
    });

    final ActionType type;
    final String label;
    final String payload;
    final int appId;
    final String hash;

    factory Action.fromRawJson(String str) => Action.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        type: json["type"] == null ? null : actionTypeValues.map[json["type"]],
        label: json["label"] == null ? null : json["label"],
        payload: json["payload"] == null ? null : json["payload"],
        appId: json["app_id"] == null ? null : json["app_id"],
        hash: json["hash"] == null ? null : json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : actionTypeValues.reverse[type],
        "label": label == null ? null : label,
        "payload": payload == null ? null : payload,
        "app_id": appId == null ? null : appId,
        "hash": hash == null ? null : hash,
    };
}

enum ActionType { TEXT, OPEN_APP }

final actionTypeValues = EnumValues({
    "open_app": ActionType.OPEN_APP,
    "text": ActionType.TEXT
});

enum Color { NEGATIVE, POSITIVE, PRIMARY, DEFAULT }

final colorValues = EnumValues({
    "default": Color.DEFAULT,
    "negative": Color.NEGATIVE,
    "positive": Color.POSITIVE,
    "primary": Color.PRIMARY
});

class Peer {
    Peer({
        this.id,
        this.type,
        this.localId,
    });

    final int id;
    final PeerType type;
    final int localId;

    factory Peer.fromRawJson(String str) => Peer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Peer.fromJson(Map<String, dynamic> json) => Peer(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : peerTypeValues.map[json["type"]],
        localId: json["local_id"] == null ? null : json["local_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : peerTypeValues.reverse[type],
        "local_id": localId == null ? null : localId,
    };
}

enum PeerType { CHAT, USER, GROUP, EMAIL }

final peerTypeValues = EnumValues({
    "chat": PeerType.CHAT,
    "email": PeerType.EMAIL,
    "group": PeerType.GROUP,
    "user": PeerType.USER
});

class PushSettings {
    PushSettings({
        this.disabledForever,
        this.noSound,
    });

    final bool disabledForever;
    final bool noSound;

    factory PushSettings.fromRawJson(String str) => PushSettings.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PushSettings.fromJson(Map<String, dynamic> json) => PushSettings(
        disabledForever: json["disabled_forever"] == null ? null : json["disabled_forever"],
        noSound: json["no_sound"] == null ? null : json["no_sound"],
    );

    Map<String, dynamic> toJson() => {
        "disabled_forever": disabledForever == null ? null : disabledForever,
        "no_sound": noSound == null ? null : noSound,
    };
}

class SortId {
    SortId({
        this.majorId,
        this.minorId,
    });

    final int majorId;
    final int minorId;

    factory SortId.fromRawJson(String str) => SortId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SortId.fromJson(Map<String, dynamic> json) => SortId(
        majorId: json["major_id"] == null ? null : json["major_id"],
        minorId: json["minor_id"] == null ? null : json["minor_id"],
    );

    Map<String, dynamic> toJson() => {
        "major_id": majorId == null ? null : majorId,
        "minor_id": minorId == null ? null : minorId,
    };
}

class Profile {
    Profile({
        this.id,
        this.firstName,
        this.lastName,
        this.isClosed,
        this.canAccessClosed,
        this.sex,
        this.screenName,
        this.photo50,
        this.photo100,
        this.online,
        this.onlineInfo,
        this.deactivated,
    });

    final int id;
    final String firstName;
    final String lastName;
    final bool isClosed;
    final bool canAccessClosed;
    final int sex;
    final String screenName;
    final String photo50;
    final String photo100;
    final int online;
    final OnlineInfo onlineInfo;
    final String deactivated;

    factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        isClosed: json["is_closed"] == null ? null : json["is_closed"],
        canAccessClosed: json["can_access_closed"] == null ? null : json["can_access_closed"],
        sex: json["sex"] == null ? null : json["sex"],
        screenName: json["screen_name"] == null ? null : json["screen_name"],
        photo50: json["photo_50"] == null ? null : json["photo_50"],
        photo100: json["photo_100"] == null ? null : json["photo_100"],
        online: json["online"] == null ? null : json["online"],
        onlineInfo: json["online_info"] == null ? null : OnlineInfo.fromJson(json["online_info"]),
        deactivated: json["deactivated"] == null ? null : json["deactivated"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "is_closed": isClosed == null ? null : isClosed,
        "can_access_closed": canAccessClosed == null ? null : canAccessClosed,
        "sex": sex == null ? null : sex,
        "screen_name": screenName == null ? null : screenName,
        "photo_50": photo50 == null ? null : photo50,
        "photo_100": photo100 == null ? null : photo100,
        "online": online == null ? null : online,
        "online_info": onlineInfo == null ? null : onlineInfo.toJson(),
        "deactivated": deactivated == null ? null : deactivated,
    };
}

class OnlineInfo {
    OnlineInfo({
        this.visible,
        this.lastSeen,
        this.isOnline,
        this.appId,
        this.isMobile,
    });

    final bool visible;
    final int lastSeen;
    final bool isOnline;
    final int appId;
    final bool isMobile;

    factory OnlineInfo.fromRawJson(String str) => OnlineInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OnlineInfo.fromJson(Map<String, dynamic> json) => OnlineInfo(
        visible: json["visible"] == null ? null : json["visible"],
        lastSeen: json["last_seen"] == null ? null : json["last_seen"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        appId: json["app_id"] == null ? null : json["app_id"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
    );

    Map<String, dynamic> toJson() => {
        "visible": visible == null ? null : visible,
        "last_seen": lastSeen == null ? null : lastSeen,
        "is_online": isOnline == null ? null : isOnline,
        "app_id": appId == null ? null : appId,
        "is_mobile": isMobile == null ? null : isMobile,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
