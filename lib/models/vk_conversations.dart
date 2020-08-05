// To parse this JSON data, do
//
//     final vkConversations = vkConversationsFromJson(jsonString);

import 'dart:convert';

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
        this.profiles,
        this.groups,
        this.emails,
    });

    final int count;
    final List<Item> items;
    final List<Profile> profiles;
    final List<Group> groups;
    final List<Email> emails;

    factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        profiles: json["profiles"] == null ? null : List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
        groups: json["groups"] == null ? null : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
        emails: json["emails"] == null ? null : List<Email>.from(json["emails"].map((x) => Email.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
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

enum GroupType { GROUP, PAGE, EVENT }

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
    final LastMessage lastMessage;

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        conversation: json["conversation"] == null ? null : Conversation.fromJson(json["conversation"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
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
        this.isMarkedUnread,
        this.important,
        this.canWrite,
        this.currentKeyboard,
        this.chatSettings,
        this.pushSettings,
    });

    final Peer peer;
    final int lastMessageId;
    final int inRead;
    final int outRead;
    final SortId sortId;
    final bool isMarkedUnread;
    final bool important;
    final CanWrite canWrite;
    final CurrentKeyboard currentKeyboard;
    final ChatSettings chatSettings;
    final PushSettings pushSettings;

    factory Conversation.fromRawJson(String str) => Conversation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        peer: json["peer"] == null ? null : Peer.fromJson(json["peer"]),
        lastMessageId: json["last_message_id"] == null ? null : json["last_message_id"],
        inRead: json["in_read"] == null ? null : json["in_read"],
        outRead: json["out_read"] == null ? null : json["out_read"],
        sortId: json["sort_id"] == null ? null : SortId.fromJson(json["sort_id"]),
        isMarkedUnread: json["is_marked_unread"] == null ? null : json["is_marked_unread"],
        important: json["important"] == null ? null : json["important"],
        canWrite: json["can_write"] == null ? null : CanWrite.fromJson(json["can_write"]),
        currentKeyboard: json["current_keyboard"] == null ? null : CurrentKeyboard.fromJson(json["current_keyboard"]),
        chatSettings: json["chat_settings"] == null ? null : ChatSettings.fromJson(json["chat_settings"]),
        pushSettings: json["push_settings"] == null ? null : PushSettings.fromJson(json["push_settings"]),
    );

    Map<String, dynamic> toJson() => {
        "peer": peer == null ? null : peer.toJson(),
        "last_message_id": lastMessageId == null ? null : lastMessageId,
        "in_read": inRead == null ? null : inRead,
        "out_read": outRead == null ? null : outRead,
        "sort_id": sortId == null ? null : sortId.toJson(),
        "is_marked_unread": isMarkedUnread == null ? null : isMarkedUnread,
        "important": important == null ? null : important,
        "can_write": canWrite == null ? null : canWrite.toJson(),
        "current_keyboard": currentKeyboard == null ? null : currentKeyboard.toJson(),
        "chat_settings": chatSettings == null ? null : chatSettings.toJson(),
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
    final Message pinnedMessage;

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
        pinnedMessage: json["pinned_message"] == null ? null : Message.fromJson(json["pinned_message"]),
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

class Message {
    Message({
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
    final List<ReplyMessageAttachment> attachments;
    final int conversationMessageId;

    factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        attachments: json["attachments"] == null ? null : List<ReplyMessageAttachment>.from(json["attachments"].map((x) => ReplyMessageAttachment.fromJson(x))),
        conversationMessageId: json["conversation_message_id"] == null ? null : json["conversation_message_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "from_id": fromId == null ? null : fromId,
        "peer_id": peerId == null ? null : peerId,
        "text": text == null ? null : text,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
        "conversation_message_id": conversationMessageId == null ? null : conversationMessageId,
    };
}

class ReplyMessageAttachment {
    ReplyMessageAttachment({
        this.type,
        this.photo,
        this.doc,
    });

    final AttachmentType type;
    final AttachmentPhoto photo;
    final Doc doc;

    factory ReplyMessageAttachment.fromRawJson(String str) => ReplyMessageAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReplyMessageAttachment.fromJson(Map<String, dynamic> json) => ReplyMessageAttachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : AttachmentPhoto.fromJson(json["photo"]),
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "photo": photo == null ? null : photo.toJson(),
        "doc": doc == null ? null : doc.toJson(),
    };
}

class Doc {
    Doc({
        this.id,
        this.ownerId,
        this.title,
        this.size,
        this.ext,
        this.date,
        this.type,
        this.url,
        this.preview,
        this.accessKey,
    });

    final int id;
    final int ownerId;
    final String title;
    final int size;
    final String ext;
    final int date;
    final int type;
    final String url;
    final Preview preview;
    final String accessKey;

    factory Doc.fromRawJson(String str) => Doc.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        size: json["size"] == null ? null : json["size"],
        ext: json["ext"] == null ? null : json["ext"],
        date: json["date"] == null ? null : json["date"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        preview: json["preview"] == null ? null : Preview.fromJson(json["preview"]),
        accessKey: json["access_key"] == null ? null : json["access_key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "title": title == null ? null : title,
        "size": size == null ? null : size,
        "ext": ext == null ? null : ext,
        "date": date == null ? null : date,
        "type": type == null ? null : type,
        "url": url == null ? null : url,
        "preview": preview == null ? null : preview.toJson(),
        "access_key": accessKey == null ? null : accessKey,
    };
}

class Preview {
    Preview({
        this.photo,
        this.video,
    });

    final PreviewPhoto photo;
    final Size video;

    factory Preview.fromRawJson(String str) => Preview.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Preview.fromJson(Map<String, dynamic> json) => Preview(
        photo: json["photo"] == null ? null : PreviewPhoto.fromJson(json["photo"]),
        video: json["video"] == null ? null : Size.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "photo": photo == null ? null : photo.toJson(),
        "video": video == null ? null : video.toJson(),
    };
}

class PreviewPhoto {
    PreviewPhoto({
        this.sizes,
    });

    final List<Size> sizes;

    factory PreviewPhoto.fromRawJson(String str) => PreviewPhoto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
        sizes: json["sizes"] == null ? null : List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sizes": sizes == null ? null : List<dynamic>.from(sizes.map((x) => x.toJson())),
    };
}

class Size {
    Size({
        this.src,
        this.width,
        this.height,
        this.type,
        this.fileSize,
        this.url,
        this.withPadding,
    });

    final String src;
    final int width;
    final int height;
    final SizeType type;
    final int fileSize;
    final String url;
    final int withPadding;

    factory Size.fromRawJson(String str) => Size.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Size.fromJson(Map<String, dynamic> json) => Size(
        src: json["src"] == null ? null : json["src"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        type: json["type"] == null ? null : sizeTypeValues.map[json["type"]],
        fileSize: json["file_size"] == null ? null : json["file_size"],
        url: json["url"] == null ? null : json["url"],
        withPadding: json["with_padding"] == null ? null : json["with_padding"],
    );

    Map<String, dynamic> toJson() => {
        "src": src == null ? null : src,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "type": type == null ? null : sizeTypeValues.reverse[type],
        "file_size": fileSize == null ? null : fileSize,
        "url": url == null ? null : url,
        "with_padding": withPadding == null ? null : withPadding,
    };
}

enum SizeType { M, S, X, Y, O, I, D, P, Q, R, W, Z, J }

final sizeTypeValues = EnumValues({
    "d": SizeType.D,
    "i": SizeType.I,
    "j": SizeType.J,
    "m": SizeType.M,
    "o": SizeType.O,
    "p": SizeType.P,
    "q": SizeType.Q,
    "r": SizeType.R,
    "s": SizeType.S,
    "w": SizeType.W,
    "x": SizeType.X,
    "y": SizeType.Y,
    "z": SizeType.Z
});

class AttachmentPhoto {
    AttachmentPhoto({
        this.albumId,
        this.date,
        this.id,
        this.ownerId,
        this.hasTags,
        this.sizes,
        this.text,
        this.userId,
        this.accessKey,
        this.postId,
        this.lat,
        this.long,
    });

    final int albumId;
    final int date;
    final int id;
    final int ownerId;
    final bool hasTags;
    final List<Size> sizes;
    final String text;
    final int userId;
    final String accessKey;
    final int postId;
    final double lat;
    final double long;

    factory AttachmentPhoto.fromRawJson(String str) => AttachmentPhoto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AttachmentPhoto.fromJson(Map<String, dynamic> json) => AttachmentPhoto(
        albumId: json["album_id"] == null ? null : json["album_id"],
        date: json["date"] == null ? null : json["date"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        hasTags: json["has_tags"] == null ? null : json["has_tags"],
        sizes: json["sizes"] == null ? null : List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
        userId: json["user_id"] == null ? null : json["user_id"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
        postId: json["post_id"] == null ? null : json["post_id"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "album_id": albumId == null ? null : albumId,
        "date": date == null ? null : date,
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "has_tags": hasTags == null ? null : hasTags,
        "sizes": sizes == null ? null : List<dynamic>.from(sizes.map((x) => x.toJson())),
        "text": text == null ? null : text,
        "user_id": userId == null ? null : userId,
        "access_key": accessKey == null ? null : accessKey,
        "post_id": postId == null ? null : postId,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
    };
}

enum AttachmentType { PHOTO, DOC }

final attachmentTypeValues = EnumValues({
    "doc": AttachmentType.DOC,
    "photo": AttachmentType.PHOTO
});

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
    final List<List<ButtonElement>> buttons;
    final bool inline;

    factory CurrentKeyboard.fromRawJson(String str) => CurrentKeyboard.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CurrentKeyboard.fromJson(Map<String, dynamic> json) => CurrentKeyboard(
        oneTime: json["one_time"] == null ? null : json["one_time"],
        authorId: json["author_id"] == null ? null : json["author_id"],
        buttons: json["buttons"] == null ? null : List<List<ButtonElement>>.from(json["buttons"].map((x) => List<ButtonElement>.from(x.map((x) => ButtonElement.fromJson(x))))),
        inline: json["inline"] == null ? null : json["inline"],
    );

    Map<String, dynamic> toJson() => {
        "one_time": oneTime == null ? null : oneTime,
        "author_id": authorId == null ? null : authorId,
        "buttons": buttons == null ? null : List<dynamic>.from(buttons.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "inline": inline == null ? null : inline,
    };
}

class ButtonElement {
    ButtonElement({
        this.action,
        this.color,
    });

    final PurpleAction action;
    final Color color;

    factory ButtonElement.fromRawJson(String str) => ButtonElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ButtonElement.fromJson(Map<String, dynamic> json) => ButtonElement(
        action: json["action"] == null ? null : PurpleAction.fromJson(json["action"]),
        color: json["color"] == null ? null : colorValues.map[json["color"]],
    );

    Map<String, dynamic> toJson() => {
        "action": action == null ? null : action.toJson(),
        "color": color == null ? null : colorValues.reverse[color],
    };
}

class PurpleAction {
    PurpleAction({
        this.type,
        this.label,
        this.payload,
        this.appId,
        this.hash,
    });

    final PurpleType type;
    final String label;
    final String payload;
    final int appId;
    final String hash;

    factory PurpleAction.fromRawJson(String str) => PurpleAction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PurpleAction.fromJson(Map<String, dynamic> json) => PurpleAction(
        type: json["type"] == null ? null : purpleTypeValues.map[json["type"]],
        label: json["label"] == null ? null : json["label"],
        payload: json["payload"] == null ? null : json["payload"],
        appId: json["app_id"] == null ? null : json["app_id"],
        hash: json["hash"] == null ? null : json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : purpleTypeValues.reverse[type],
        "label": label == null ? null : label,
        "payload": payload == null ? null : payload,
        "app_id": appId == null ? null : appId,
        "hash": hash == null ? null : hash,
    };
}

enum PurpleType { TEXT, OPEN_APP }

final purpleTypeValues = EnumValues({
    "open_app": PurpleType.OPEN_APP,
    "text": PurpleType.TEXT
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

enum PeerType { USER, GROUP, CHAT, EMAIL }

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

class LastMessage {
    LastMessage({
        this.date,
        this.fromId,
        this.id,
        this.out,
        this.peerId,
        this.text,
        this.conversationMessageId,
        this.fwdMessages,
        this.important,
        this.randomId,
        this.attachments,
        this.isHidden,
        this.ref,
        this.replyMessage,
        this.updateTime,
        this.action,
        this.messageTag,
    });

    final int date;
    final int fromId;
    final int id;
    final int out;
    final int peerId;
    final String text;
    final int conversationMessageId;
    final List<Message> fwdMessages;
    final bool important;
    final int randomId;
    final List<LastMessageAttachment> attachments;
    final bool isHidden;
    final String ref;
    final Message replyMessage;
    final int updateTime;
    final LastMessageAction action;
    final String messageTag;

    factory LastMessage.fromRawJson(String str) => LastMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        id: json["id"] == null ? null : json["id"],
        out: json["out"] == null ? null : json["out"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        conversationMessageId: json["conversation_message_id"] == null ? null : json["conversation_message_id"],
        fwdMessages: json["fwd_messages"] == null ? null : List<Message>.from(json["fwd_messages"].map((x) => Message.fromJson(x))),
        important: json["important"] == null ? null : json["important"],
        randomId: json["random_id"] == null ? null : json["random_id"],
        attachments: json["attachments"] == null ? null : List<LastMessageAttachment>.from(json["attachments"].map((x) => LastMessageAttachment.fromJson(x))),
        isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
        ref: json["ref"] == null ? null : json["ref"],
        replyMessage: json["reply_message"] == null ? null : Message.fromJson(json["reply_message"]),
        updateTime: json["update_time"] == null ? null : json["update_time"],
        action: json["action"] == null ? null : LastMessageAction.fromJson(json["action"]),
        messageTag: json["message_tag"] == null ? null : json["message_tag"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "from_id": fromId == null ? null : fromId,
        "id": id == null ? null : id,
        "out": out == null ? null : out,
        "peer_id": peerId == null ? null : peerId,
        "text": text == null ? null : text,
        "conversation_message_id": conversationMessageId == null ? null : conversationMessageId,
        "fwd_messages": fwdMessages == null ? null : List<dynamic>.from(fwdMessages.map((x) => x.toJson())),
        "important": important == null ? null : important,
        "random_id": randomId == null ? null : randomId,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
        "is_hidden": isHidden == null ? null : isHidden,
        "ref": ref == null ? null : ref,
        "reply_message": replyMessage == null ? null : replyMessage.toJson(),
        "update_time": updateTime == null ? null : updateTime,
        "action": action == null ? null : action.toJson(),
        "message_tag": messageTag == null ? null : messageTag,
    };
}

class LastMessageAction {
    LastMessageAction({
        this.type,
        this.memberId,
    });

    final FluffyType type;
    final int memberId;

    factory LastMessageAction.fromRawJson(String str) => LastMessageAction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessageAction.fromJson(Map<String, dynamic> json) => LastMessageAction(
        type: json["type"] == null ? null : fluffyTypeValues.map[json["type"]],
        memberId: json["member_id"] == null ? null : json["member_id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : fluffyTypeValues.reverse[type],
        "member_id": memberId == null ? null : memberId,
    };
}

enum FluffyType { CHAT_KICK_USER }

final fluffyTypeValues = EnumValues({
    "chat_kick_user": FluffyType.CHAT_KICK_USER
});

class LastMessageAttachment {
    LastMessageAttachment({
        this.type,
        this.photo,
        this.wall,
        this.link,
        this.sticker,
        this.story,
        this.doc,
        this.video,
        this.gift,
    });

    final String type;
    final AttachmentPhoto photo;
    final Wall wall;
    final Link link;
    final Sticker sticker;
    final Story story;
    final Doc doc;
    final Video video;
    final Gift gift;

    factory LastMessageAttachment.fromRawJson(String str) => LastMessageAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastMessageAttachment.fromJson(Map<String, dynamic> json) => LastMessageAttachment(
        type: json["type"] == null ? null : json["type"],
        photo: json["photo"] == null ? null : AttachmentPhoto.fromJson(json["photo"]),
        wall: json["wall"] == null ? null : Wall.fromJson(json["wall"]),
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        sticker: json["sticker"] == null ? null : Sticker.fromJson(json["sticker"]),
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        gift: json["gift"] == null ? null : Gift.fromJson(json["gift"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "photo": photo == null ? null : photo.toJson(),
        "wall": wall == null ? null : wall.toJson(),
        "link": link == null ? null : link.toJson(),
        "sticker": sticker == null ? null : sticker.toJson(),
        "story": story == null ? null : story.toJson(),
        "doc": doc == null ? null : doc.toJson(),
        "video": video == null ? null : video.toJson(),
        "gift": gift == null ? null : gift.toJson(),
    };
}

class Gift {
    Gift({
        this.id,
        this.thumb256,
        this.thumb48,
        this.thumb96,
        this.stickersProductId,
    });

    final int id;
    final String thumb256;
    final String thumb48;
    final String thumb96;
    final int stickersProductId;

    factory Gift.fromRawJson(String str) => Gift.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"] == null ? null : json["id"],
        thumb256: json["thumb_256"] == null ? null : json["thumb_256"],
        thumb48: json["thumb_48"] == null ? null : json["thumb_48"],
        thumb96: json["thumb_96"] == null ? null : json["thumb_96"],
        stickersProductId: json["stickers_product_id"] == null ? null : json["stickers_product_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "thumb_256": thumb256 == null ? null : thumb256,
        "thumb_48": thumb48 == null ? null : thumb48,
        "thumb_96": thumb96 == null ? null : thumb96,
        "stickers_product_id": stickersProductId == null ? null : stickersProductId,
    };
}

class Link {
    Link({
        this.url,
        this.title,
        this.caption,
        this.description,
        this.photo,
        this.button,
        this.isFavorite,
    });

    final String url;
    final String title;
    final String caption;
    final String description;
    final AttachmentPhoto photo;
    final LinkButton button;
    final bool isFavorite;

    factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : AttachmentPhoto.fromJson(json["photo"]),
        button: json["button"] == null ? null : LinkButton.fromJson(json["button"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "caption": caption == null ? null : caption,
        "description": description == null ? null : description,
        "photo": photo == null ? null : photo.toJson(),
        "button": button == null ? null : button.toJson(),
        "is_favorite": isFavorite == null ? null : isFavorite,
    };
}

class LinkButton {
    LinkButton({
        this.title,
        this.action,
    });

    final String title;
    final FluffyAction action;

    factory LinkButton.fromRawJson(String str) => LinkButton.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LinkButton.fromJson(Map<String, dynamic> json) => LinkButton(
        title: json["title"] == null ? null : json["title"],
        action: json["action"] == null ? null : FluffyAction.fromJson(json["action"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "action": action == null ? null : action.toJson(),
    };
}

class FluffyAction {
    FluffyAction({
        this.type,
        this.url,
    });

    final String type;
    final String url;

    factory FluffyAction.fromRawJson(String str) => FluffyAction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FluffyAction.fromJson(Map<String, dynamic> json) => FluffyAction(
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "url": url == null ? null : url,
    };
}

class Sticker {
    Sticker({
        this.productId,
        this.stickerId,
        this.images,
        this.imagesWithBackground,
        this.animationUrl,
    });

    final int productId;
    final int stickerId;
    final List<Size> images;
    final List<Size> imagesWithBackground;
    final String animationUrl;

    factory Sticker.fromRawJson(String str) => Sticker.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sticker.fromJson(Map<String, dynamic> json) => Sticker(
        productId: json["product_id"] == null ? null : json["product_id"],
        stickerId: json["sticker_id"] == null ? null : json["sticker_id"],
        images: json["images"] == null ? null : List<Size>.from(json["images"].map((x) => Size.fromJson(x))),
        imagesWithBackground: json["images_with_background"] == null ? null : List<Size>.from(json["images_with_background"].map((x) => Size.fromJson(x))),
        animationUrl: json["animation_url"] == null ? null : json["animation_url"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "sticker_id": stickerId == null ? null : stickerId,
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
        "images_with_background": imagesWithBackground == null ? null : List<dynamic>.from(imagesWithBackground.map((x) => x.toJson())),
        "animation_url": animationUrl == null ? null : animationUrl,
    };
}

class Story {
    Story({
        this.id,
        this.ownerId,
        this.accessKey,
        this.canComment,
        this.canReply,
        this.canSee,
        this.canLike,
        this.canShare,
        this.canHide,
        this.date,
        this.expiresAt,
        this.photo,
        this.replies,
        this.isOneTime,
        this.trackCode,
        this.type,
        this.clickableStickers,
        this.views,
        this.likesCount,
        this.isRestricted,
        this.noSound,
        this.needMute,
        this.muteReply,
        this.canAsk,
        this.canAskAnonymous,
        this.isOwnerPinned,
        this.narrativesCount,
        this.firstNarrativeTitle,
        this.canUseInNarrative,
    });

    final int id;
    final int ownerId;
    final String accessKey;
    final int canComment;
    final int canReply;
    final int canSee;
    final bool canLike;
    final int canShare;
    final int canHide;
    final int date;
    final int expiresAt;
    final AttachmentPhoto photo;
    final Replies replies;
    final bool isOneTime;
    final String trackCode;
    final AttachmentType type;
    final ClickableStickers clickableStickers;
    final int views;
    final int likesCount;
    final bool isRestricted;
    final bool noSound;
    final bool needMute;
    final bool muteReply;
    final int canAsk;
    final int canAskAnonymous;
    final bool isOwnerPinned;
    final int narrativesCount;
    final String firstNarrativeTitle;
    final bool canUseInNarrative;

    factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
        canComment: json["can_comment"] == null ? null : json["can_comment"],
        canReply: json["can_reply"] == null ? null : json["can_reply"],
        canSee: json["can_see"] == null ? null : json["can_see"],
        canLike: json["can_like"] == null ? null : json["can_like"],
        canShare: json["can_share"] == null ? null : json["can_share"],
        canHide: json["can_hide"] == null ? null : json["can_hide"],
        date: json["date"] == null ? null : json["date"],
        expiresAt: json["expires_at"] == null ? null : json["expires_at"],
        photo: json["photo"] == null ? null : AttachmentPhoto.fromJson(json["photo"]),
        replies: json["replies"] == null ? null : Replies.fromJson(json["replies"]),
        isOneTime: json["is_one_time"] == null ? null : json["is_one_time"],
        trackCode: json["track_code"] == null ? null : json["track_code"],
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        clickableStickers: json["clickable_stickers"] == null ? null : ClickableStickers.fromJson(json["clickable_stickers"]),
        views: json["views"] == null ? null : json["views"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        isRestricted: json["is_restricted"] == null ? null : json["is_restricted"],
        noSound: json["no_sound"] == null ? null : json["no_sound"],
        needMute: json["need_mute"] == null ? null : json["need_mute"],
        muteReply: json["mute_reply"] == null ? null : json["mute_reply"],
        canAsk: json["can_ask"] == null ? null : json["can_ask"],
        canAskAnonymous: json["can_ask_anonymous"] == null ? null : json["can_ask_anonymous"],
        isOwnerPinned: json["is_owner_pinned"] == null ? null : json["is_owner_pinned"],
        narrativesCount: json["narratives_count"] == null ? null : json["narratives_count"],
        firstNarrativeTitle: json["first_narrative_title"] == null ? null : json["first_narrative_title"],
        canUseInNarrative: json["can_use_in_narrative"] == null ? null : json["can_use_in_narrative"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "access_key": accessKey == null ? null : accessKey,
        "can_comment": canComment == null ? null : canComment,
        "can_reply": canReply == null ? null : canReply,
        "can_see": canSee == null ? null : canSee,
        "can_like": canLike == null ? null : canLike,
        "can_share": canShare == null ? null : canShare,
        "can_hide": canHide == null ? null : canHide,
        "date": date == null ? null : date,
        "expires_at": expiresAt == null ? null : expiresAt,
        "photo": photo == null ? null : photo.toJson(),
        "replies": replies == null ? null : replies.toJson(),
        "is_one_time": isOneTime == null ? null : isOneTime,
        "track_code": trackCode == null ? null : trackCode,
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "clickable_stickers": clickableStickers == null ? null : clickableStickers.toJson(),
        "views": views == null ? null : views,
        "likes_count": likesCount == null ? null : likesCount,
        "is_restricted": isRestricted == null ? null : isRestricted,
        "no_sound": noSound == null ? null : noSound,
        "need_mute": needMute == null ? null : needMute,
        "mute_reply": muteReply == null ? null : muteReply,
        "can_ask": canAsk == null ? null : canAsk,
        "can_ask_anonymous": canAskAnonymous == null ? null : canAskAnonymous,
        "is_owner_pinned": isOwnerPinned == null ? null : isOwnerPinned,
        "narratives_count": narrativesCount == null ? null : narrativesCount,
        "first_narrative_title": firstNarrativeTitle == null ? null : firstNarrativeTitle,
        "can_use_in_narrative": canUseInNarrative == null ? null : canUseInNarrative,
    };
}

class ClickableStickers {
    ClickableStickers({
        this.originalHeight,
        this.originalWidth,
        this.clickableStickers,
    });

    final int originalHeight;
    final int originalWidth;
    final List<ClickableSticker> clickableStickers;

    factory ClickableStickers.fromRawJson(String str) => ClickableStickers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClickableStickers.fromJson(Map<String, dynamic> json) => ClickableStickers(
        originalHeight: json["original_height"] == null ? null : json["original_height"],
        originalWidth: json["original_width"] == null ? null : json["original_width"],
        clickableStickers: json["clickable_stickers"] == null ? null : List<ClickableSticker>.from(json["clickable_stickers"].map((x) => ClickableSticker.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "original_height": originalHeight == null ? null : originalHeight,
        "original_width": originalWidth == null ? null : originalWidth,
        "clickable_stickers": clickableStickers == null ? null : List<dynamic>.from(clickableStickers.map((x) => x.toJson())),
    };
}

class ClickableSticker {
    ClickableSticker({
        this.id,
        this.type,
        this.clickableArea,
        this.linkObject,
        this.tooltipText,
    });

    final int id;
    final String type;
    final List<ClickableArea> clickableArea;
    final LinkObject linkObject;
    final String tooltipText;

    factory ClickableSticker.fromRawJson(String str) => ClickableSticker.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClickableSticker.fromJson(Map<String, dynamic> json) => ClickableSticker(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        clickableArea: json["clickable_area"] == null ? null : List<ClickableArea>.from(json["clickable_area"].map((x) => ClickableArea.fromJson(x))),
        linkObject: json["link_object"] == null ? null : LinkObject.fromJson(json["link_object"]),
        tooltipText: json["tooltip_text"] == null ? null : json["tooltip_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "clickable_area": clickableArea == null ? null : List<dynamic>.from(clickableArea.map((x) => x.toJson())),
        "link_object": linkObject == null ? null : linkObject.toJson(),
        "tooltip_text": tooltipText == null ? null : tooltipText,
    };
}

class ClickableArea {
    ClickableArea({
        this.x,
        this.y,
    });

    final int x;
    final int y;

    factory ClickableArea.fromRawJson(String str) => ClickableArea.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClickableArea.fromJson(Map<String, dynamic> json) => ClickableArea(
        x: json["x"] == null ? null : json["x"],
        y: json["y"] == null ? null : json["y"],
    );

    Map<String, dynamic> toJson() => {
        "x": x == null ? null : x,
        "y": y == null ? null : y,
    };
}

class LinkObject {
    LinkObject({
        this.url,
        this.title,
        this.caption,
        this.description,
    });

    final String url;
    final String title;
    final String caption;
    final String description;

    factory LinkObject.fromRawJson(String str) => LinkObject.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LinkObject.fromJson(Map<String, dynamic> json) => LinkObject(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "caption": caption == null ? null : caption,
        "description": description == null ? null : description,
    };
}

class Replies {
    Replies({
        this.count,
        this.repliesNew,
    });

    final int count;
    final int repliesNew;

    factory Replies.fromRawJson(String str) => Replies.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Replies.fromJson(Map<String, dynamic> json) => Replies(
        count: json["count"] == null ? null : json["count"],
        repliesNew: json["new"] == null ? null : json["new"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "new": repliesNew == null ? null : repliesNew,
    };
}

class Video {
    Video({
        this.accessKey,
        this.canAdd,
        this.comments,
        this.date,
        this.description,
        this.duration,
        this.image,
        this.firstFrame,
        this.width,
        this.height,
        this.id,
        this.ownerId,
        this.title,
        this.isFavorite,
        this.trackCode,
        this.type,
        this.views,
    });

    final String accessKey;
    final int canAdd;
    final int comments;
    final int date;
    final String description;
    final int duration;
    final List<Size> image;
    final List<Size> firstFrame;
    final int width;
    final int height;
    final int id;
    final int ownerId;
    final String title;
    final bool isFavorite;
    final String trackCode;
    final String type;
    final int views;

    factory Video.fromRawJson(String str) => Video.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        accessKey: json["access_key"] == null ? null : json["access_key"],
        canAdd: json["can_add"] == null ? null : json["can_add"],
        comments: json["comments"] == null ? null : json["comments"],
        date: json["date"] == null ? null : json["date"],
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        image: json["image"] == null ? null : List<Size>.from(json["image"].map((x) => Size.fromJson(x))),
        firstFrame: json["first_frame"] == null ? null : List<Size>.from(json["first_frame"].map((x) => Size.fromJson(x))),
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
        trackCode: json["track_code"] == null ? null : json["track_code"],
        type: json["type"] == null ? null : json["type"],
        views: json["views"] == null ? null : json["views"],
    );

    Map<String, dynamic> toJson() => {
        "access_key": accessKey == null ? null : accessKey,
        "can_add": canAdd == null ? null : canAdd,
        "comments": comments == null ? null : comments,
        "date": date == null ? null : date,
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "image": image == null ? null : List<dynamic>.from(image.map((x) => x.toJson())),
        "first_frame": firstFrame == null ? null : List<dynamic>.from(firstFrame.map((x) => x.toJson())),
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "title": title == null ? null : title,
        "is_favorite": isFavorite == null ? null : isFavorite,
        "track_code": trackCode == null ? null : trackCode,
        "type": type == null ? null : type,
        "views": views == null ? null : views,
    };
}

class Wall {
    Wall({
        this.id,
        this.fromId,
        this.toId,
        this.date,
        this.postType,
        this.text,
        this.markedAsAds,
        this.attachments,
        this.postSource,
        this.comments,
        this.likes,
        this.reposts,
        this.views,
        this.isFavorite,
        this.accessKey,
    });

    final int id;
    final int fromId;
    final int toId;
    final int date;
    final String postType;
    final String text;
    final int markedAsAds;
    final List<ReplyMessageAttachment> attachments;
    final PostSource postSource;
    final Comments comments;
    final Likes likes;
    final Reposts reposts;
    final Views views;
    final bool isFavorite;
    final String accessKey;

    factory Wall.fromRawJson(String str) => Wall.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wall.fromJson(Map<String, dynamic> json) => Wall(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        toId: json["to_id"] == null ? null : json["to_id"],
        date: json["date"] == null ? null : json["date"],
        postType: json["post_type"] == null ? null : json["post_type"],
        text: json["text"] == null ? null : json["text"],
        markedAsAds: json["marked_as_ads"] == null ? null : json["marked_as_ads"],
        attachments: json["attachments"] == null ? null : List<ReplyMessageAttachment>.from(json["attachments"].map((x) => ReplyMessageAttachment.fromJson(x))),
        postSource: json["post_source"] == null ? null : PostSource.fromJson(json["post_source"]),
        comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
        likes: json["likes"] == null ? null : Likes.fromJson(json["likes"]),
        reposts: json["reposts"] == null ? null : Reposts.fromJson(json["reposts"]),
        views: json["views"] == null ? null : Views.fromJson(json["views"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "from_id": fromId == null ? null : fromId,
        "to_id": toId == null ? null : toId,
        "date": date == null ? null : date,
        "post_type": postType == null ? null : postType,
        "text": text == null ? null : text,
        "marked_as_ads": markedAsAds == null ? null : markedAsAds,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
        "post_source": postSource == null ? null : postSource.toJson(),
        "comments": comments == null ? null : comments.toJson(),
        "likes": likes == null ? null : likes.toJson(),
        "reposts": reposts == null ? null : reposts.toJson(),
        "views": views == null ? null : views.toJson(),
        "is_favorite": isFavorite == null ? null : isFavorite,
        "access_key": accessKey == null ? null : accessKey,
    };
}

class Comments {
    Comments({
        this.count,
        this.canPost,
        this.groupsCanPost,
    });

    final int count;
    final int canPost;
    final bool groupsCanPost;

    factory Comments.fromRawJson(String str) => Comments.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        count: json["count"] == null ? null : json["count"],
        canPost: json["can_post"] == null ? null : json["can_post"],
        groupsCanPost: json["groups_can_post"] == null ? null : json["groups_can_post"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "can_post": canPost == null ? null : canPost,
        "groups_can_post": groupsCanPost == null ? null : groupsCanPost,
    };
}

class Likes {
    Likes({
        this.count,
        this.userLikes,
        this.canLike,
        this.canPublish,
    });

    final int count;
    final int userLikes;
    final int canLike;
    final int canPublish;

    factory Likes.fromRawJson(String str) => Likes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        count: json["count"] == null ? null : json["count"],
        userLikes: json["user_likes"] == null ? null : json["user_likes"],
        canLike: json["can_like"] == null ? null : json["can_like"],
        canPublish: json["can_publish"] == null ? null : json["can_publish"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "user_likes": userLikes == null ? null : userLikes,
        "can_like": canLike == null ? null : canLike,
        "can_publish": canPublish == null ? null : canPublish,
    };
}

class PostSource {
    PostSource({
        this.type,
    });

    final String type;

    factory PostSource.fromRawJson(String str) => PostSource.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PostSource.fromJson(Map<String, dynamic> json) => PostSource(
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
    };
}

class Reposts {
    Reposts({
        this.count,
        this.userReposted,
    });

    final int count;
    final int userReposted;

    factory Reposts.fromRawJson(String str) => Reposts.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Reposts.fromJson(Map<String, dynamic> json) => Reposts(
        count: json["count"] == null ? null : json["count"],
        userReposted: json["user_reposted"] == null ? null : json["user_reposted"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "user_reposted": userReposted == null ? null : userReposted,
    };
}

class Views {
    Views({
        this.count,
    });

    final int count;

    factory Views.fromRawJson(String str) => Views.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Views.fromJson(Map<String, dynamic> json) => Views(
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
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
        this.onlineApp,
        this.onlineMobile,
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
    final int onlineApp;
    final int onlineMobile;
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
        onlineApp: json["online_app"] == null ? null : json["online_app"],
        onlineMobile: json["online_mobile"] == null ? null : json["online_mobile"],
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
        "online_app": onlineApp == null ? null : onlineApp,
        "online_mobile": onlineMobile == null ? null : onlineMobile,
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
        this.status,
    });

    final bool visible;
    final int lastSeen;
    final bool isOnline;
    final int appId;
    final bool isMobile;
    final String status;

    factory OnlineInfo.fromRawJson(String str) => OnlineInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OnlineInfo.fromJson(Map<String, dynamic> json) => OnlineInfo(
        visible: json["visible"] == null ? null : json["visible"],
        lastSeen: json["last_seen"] == null ? null : json["last_seen"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        appId: json["app_id"] == null ? null : json["app_id"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "visible": visible == null ? null : visible,
        "last_seen": lastSeen == null ? null : lastSeen,
        "is_online": isOnline == null ? null : isOnline,
        "app_id": appId == null ? null : appId,
        "is_mobile": isMobile == null ? null : isMobile,
        "status": status == null ? null : status,
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
