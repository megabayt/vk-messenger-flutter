// To parse this JSON data, do
//
//     final vkConversation = vkConversationFromJson(jsonString);

import 'dart:convert';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Profile, Group;

class VkConversation {
    VkConversation({
        this.response,
    });

    final Response response;

    factory VkConversation.fromRawJson(String str) => VkConversation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VkConversation.fromJson(Map<String, dynamic> json) => VkConversation(
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
        this.conversations,
        this.profiles,
        this.groups,
    });

    final int count;
    final List<Item> items;
    final List<Conversation> conversations;
    final List<Profile> profiles;
    final List<Group> groups;

    factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        count: json["count"] == null ? null : json["count"],
        items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
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
    });

    final Peer peer;
    final int lastMessageId;
    final int inRead;
    final int outRead;
    final SortId sortId;
    final bool isMarkedUnread;
    final bool important;
    final CanWrite canWrite;

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
    };
}

class CanWrite {
    CanWrite({
        this.allowed,
    });

    final bool allowed;

    factory CanWrite.fromRawJson(String str) => CanWrite.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CanWrite.fromJson(Map<String, dynamic> json) => CanWrite(
        allowed: json["allowed"] == null ? null : json["allowed"],
    );

    Map<String, dynamic> toJson() => {
        "allowed": allowed == null ? null : allowed,
    };
}

class Peer {
    Peer({
        this.id,
        this.type,
        this.localId,
    });

    final int id;
    final String type;
    final int localId;

    factory Peer.fromRawJson(String str) => Peer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Peer.fromJson(Map<String, dynamic> json) => Peer(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        localId: json["local_id"] == null ? null : json["local_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "local_id": localId == null ? null : localId,
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

enum GroupType { GROUP, PAGE }

final groupTypeValues = EnumValues({
    "group": GroupType.GROUP,
    "page": GroupType.PAGE
});

class Item {
    Item({
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
        this.updateTime,
        this.ref,
    });

    final int date;
    final int fromId;
    final int id;
    final int out;
    final int peerId;
    final String text;
    final int conversationMessageId;
    final List<FwdMessage> fwdMessages;
    final bool important;
    final int randomId;
    final List<ItemAttachment> attachments;
    final bool isHidden;
    final int updateTime;
    final Ref ref;

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        id: json["id"] == null ? null : json["id"],
        out: json["out"] == null ? null : json["out"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        conversationMessageId: json["conversation_message_id"] == null ? null : json["conversation_message_id"],
        fwdMessages: json["fwd_messages"] == null ? null : List<FwdMessage>.from(json["fwd_messages"].map((x) => FwdMessage.fromJson(x))),
        important: json["important"] == null ? null : json["important"],
        randomId: json["random_id"] == null ? null : json["random_id"],
        attachments: json["attachments"] == null ? null : List<ItemAttachment>.from(json["attachments"].map((x) => ItemAttachment.fromJson(x))),
        isHidden: json["is_hidden"] == null ? null : json["is_hidden"],
        updateTime: json["update_time"] == null ? null : json["update_time"],
        ref: json["ref"] == null ? null : refValues.map[json["ref"]],
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
        "update_time": updateTime == null ? null : updateTime,
        "ref": ref == null ? null : refValues.reverse[ref],
    };
}

class ItemAttachment {
    ItemAttachment({
        this.type,
        this.photo,
        this.link,
        this.wall,
        this.sticker,
        this.doc,
        this.wallReply,
        this.video,
        this.story,
    });

    final AttachmentType type;
    final LinkPhoto photo;
    final PurpleLink link;
    final Wall wall;
    final Sticker sticker;
    final PurpleDoc doc;
    final WallReply wallReply;
    final Video video;
    final Story story;

    factory ItemAttachment.fromRawJson(String str) => ItemAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemAttachment.fromJson(Map<String, dynamic> json) => ItemAttachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
        link: json["link"] == null ? null : PurpleLink.fromJson(json["link"]),
        wall: json["wall"] == null ? null : Wall.fromJson(json["wall"]),
        sticker: json["sticker"] == null ? null : Sticker.fromJson(json["sticker"]),
        doc: json["doc"] == null ? null : PurpleDoc.fromJson(json["doc"]),
        wallReply: json["wall_reply"] == null ? null : WallReply.fromJson(json["wall_reply"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "photo": photo == null ? null : photo.toJson(),
        "link": link == null ? null : link.toJson(),
        "wall": wall == null ? null : wall.toJson(),
        "sticker": sticker == null ? null : sticker.toJson(),
        "doc": doc == null ? null : doc.toJson(),
        "wall_reply": wallReply == null ? null : wallReply.toJson(),
        "video": video == null ? null : video.toJson(),
        "story": story == null ? null : story.toJson(),
    };
}

class PurpleDoc {
    PurpleDoc({
        this.id,
        this.ownerId,
        this.title,
        this.size,
        this.ext,
        this.date,
        this.type,
        this.url,
        this.accessKey,
        this.preview,
    });

    final int id;
    final int ownerId;
    final String title;
    final int size;
    final String ext;
    final int date;
    final int type;
    final String url;
    final String accessKey;
    final PurplePreview preview;

    factory PurpleDoc.fromRawJson(String str) => PurpleDoc.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PurpleDoc.fromJson(Map<String, dynamic> json) => PurpleDoc(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        size: json["size"] == null ? null : json["size"],
        ext: json["ext"] == null ? null : json["ext"],
        date: json["date"] == null ? null : json["date"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
        preview: json["preview"] == null ? null : PurplePreview.fromJson(json["preview"]),
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
        "access_key": accessKey == null ? null : accessKey,
        "preview": preview == null ? null : preview.toJson(),
    };
}

class PurplePreview {
    PurplePreview({
        this.photo,
    });

    final PreviewPhoto photo;

    factory PurplePreview.fromRawJson(String str) => PurplePreview.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PurplePreview.fromJson(Map<String, dynamic> json) => PurplePreview(
        photo: json["photo"] == null ? null : PreviewPhoto.fromJson(json["photo"]),
    );

    Map<String, dynamic> toJson() => {
        "photo": photo == null ? null : photo.toJson(),
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
        this.url,
        this.withPadding,
        this.fileSize,
    });

    final String src;
    final int width;
    final int height;
    final SizeType type;
    final String url;
    final int withPadding;
    final int fileSize;

    factory Size.fromRawJson(String str) => Size.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Size.fromJson(Map<String, dynamic> json) => Size(
        src: json["src"] == null ? null : json["src"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        type: json["type"] == null ? null : sizeTypeValues.map[json["type"]],
        url: json["url"] == null ? null : json["url"],
        withPadding: json["with_padding"] == null ? null : json["with_padding"],
        fileSize: json["file_size"] == null ? null : json["file_size"],
    );

    Map<String, dynamic> toJson() => {
        "src": src == null ? null : src,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "type": type == null ? null : sizeTypeValues.reverse[type],
        "url": url == null ? null : url,
        "with_padding": withPadding == null ? null : withPadding,
        "file_size": fileSize == null ? null : fileSize,
    };
}

enum SizeType { M, S, X, Y, Z, O, I, D, K, L, P, Q, R, W }

final sizeTypeValues = EnumValues({
    "d": SizeType.D,
    "i": SizeType.I,
    "k": SizeType.K,
    "l": SizeType.L,
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

class PurpleLink {
    PurpleLink({
        this.url,
        this.title,
        this.caption,
        this.description,
        this.photo,
        this.isFavorite,
    });

    final String url;
    final String title;
    final String caption;
    final String description;
    final LinkPhoto photo;
    final bool isFavorite;

    factory PurpleLink.fromRawJson(String str) => PurpleLink.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PurpleLink.fromJson(Map<String, dynamic> json) => PurpleLink(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "caption": caption == null ? null : caption,
        "description": description == null ? null : description,
        "photo": photo == null ? null : photo.toJson(),
        "is_favorite": isFavorite == null ? null : isFavorite,
    };
}

class LinkPhoto {
    LinkPhoto({
        this.albumId,
        this.date,
        this.id,
        this.ownerId,
        this.hasTags,
        this.sizes,
        this.text,
        this.accessKey,
        this.userId,
        this.postId,
    });

    final int albumId;
    final int date;
    final int id;
    final int ownerId;
    final bool hasTags;
    final List<Size> sizes;
    final String text;
    final String accessKey;
    final int userId;
    final int postId;

    factory LinkPhoto.fromRawJson(String str) => LinkPhoto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LinkPhoto.fromJson(Map<String, dynamic> json) => LinkPhoto(
        albumId: json["album_id"] == null ? null : json["album_id"],
        date: json["date"] == null ? null : json["date"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        hasTags: json["has_tags"] == null ? null : json["has_tags"],
        sizes: json["sizes"] == null ? null : List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
        userId: json["user_id"] == null ? null : json["user_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
    );

    Map<String, dynamic> toJson() => {
        "album_id": albumId == null ? null : albumId,
        "date": date == null ? null : date,
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "has_tags": hasTags == null ? null : hasTags,
        "sizes": sizes == null ? null : List<dynamic>.from(sizes.map((x) => x.toJson())),
        "text": text == null ? null : text,
        "access_key": accessKey == null ? null : accessKey,
        "user_id": userId == null ? null : userId,
        "post_id": postId == null ? null : postId,
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
        this.date,
        this.expiresAt,
        this.isExpired,
        this.isOneTime,
    });

    final int id;
    final int ownerId;
    final int date;
    final int expiresAt;
    final bool isExpired;
    final bool isOneTime;

    factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        date: json["date"] == null ? null : json["date"],
        expiresAt: json["expires_at"] == null ? null : json["expires_at"],
        isExpired: json["is_expired"] == null ? null : json["is_expired"],
        isOneTime: json["is_one_time"] == null ? null : json["is_one_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "date": date == null ? null : date,
        "expires_at": expiresAt == null ? null : expiresAt,
        "is_expired": isExpired == null ? null : isExpired,
        "is_one_time": isOneTime == null ? null : isOneTime,
    };
}

enum AttachmentType { PHOTO, LINK, WALL, STICKER, DOC, WALL_REPLY, VIDEO, STORY, POLL, GIFT }

final attachmentTypeValues = EnumValues({
    "doc": AttachmentType.DOC,
    "link": AttachmentType.LINK,
    "photo": AttachmentType.PHOTO,
    "poll": AttachmentType.POLL,
    "sticker": AttachmentType.STICKER,
    "story": AttachmentType.STORY,
    "video": AttachmentType.VIDEO,
    "wall": AttachmentType.WALL,
    "wall_reply": AttachmentType.WALL_REPLY,
    "gift": AttachmentType.GIFT
});

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
        this.repeat,
        this.type,
        this.views,
        this.canEdit,
        this.canAttachLink,
        this.localViews,
        this.platform,
        this.canComment,
        this.canLike,
        this.canRepost,
        this.canSubscribe,
        this.canAddToFaves,
        this.userId,
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
    final int repeat;
    final AttachmentType type;
    final int views;
    final int canEdit;
    final int canAttachLink;
    final int localViews;
    final String platform;
    final int canComment;
    final int canLike;
    final int canRepost;
    final int canSubscribe;
    final int canAddToFaves;
    final int userId;

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
        repeat: json["repeat"] == null ? null : json["repeat"],
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        views: json["views"] == null ? null : json["views"],
        canEdit: json["can_edit"] == null ? null : json["can_edit"],
        canAttachLink: json["can_attach_link"] == null ? null : json["can_attach_link"],
        localViews: json["local_views"] == null ? null : json["local_views"],
        platform: json["platform"] == null ? null : json["platform"],
        canComment: json["can_comment"] == null ? null : json["can_comment"],
        canLike: json["can_like"] == null ? null : json["can_like"],
        canRepost: json["can_repost"] == null ? null : json["can_repost"],
        canSubscribe: json["can_subscribe"] == null ? null : json["can_subscribe"],
        canAddToFaves: json["can_add_to_faves"] == null ? null : json["can_add_to_faves"],
        userId: json["user_id"] == null ? null : json["user_id"],
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
        "repeat": repeat == null ? null : repeat,
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "views": views == null ? null : views,
        "can_edit": canEdit == null ? null : canEdit,
        "can_attach_link": canAttachLink == null ? null : canAttachLink,
        "local_views": localViews == null ? null : localViews,
        "platform": platform == null ? null : platform,
        "can_comment": canComment == null ? null : canComment,
        "can_like": canLike == null ? null : canLike,
        "can_repost": canRepost == null ? null : canRepost,
        "can_subscribe": canSubscribe == null ? null : canSubscribe,
        "can_add_to_faves": canAddToFaves == null ? null : canAddToFaves,
        "user_id": userId == null ? null : userId,
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
        this.copyright,
        this.signerId,
    });

    final int id;
    final int fromId;
    final int toId;
    final int date;
    final PostType postType;
    final String text;
    final int markedAsAds;
    final List<WallAttachment> attachments;
    final PostSource postSource;
    final Comments comments;
    final WallLikes likes;
    final Reposts reposts;
    final Views views;
    final bool isFavorite;
    final String accessKey;
    final Copyright copyright;
    final int signerId;

    factory Wall.fromRawJson(String str) => Wall.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wall.fromJson(Map<String, dynamic> json) => Wall(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        toId: json["to_id"] == null ? null : json["to_id"],
        date: json["date"] == null ? null : json["date"],
        postType: json["post_type"] == null ? null : postTypeValues.map[json["post_type"]],
        text: json["text"] == null ? null : json["text"],
        markedAsAds: json["marked_as_ads"] == null ? null : json["marked_as_ads"],
        attachments: json["attachments"] == null ? null : List<WallAttachment>.from(json["attachments"].map((x) => WallAttachment.fromJson(x))),
        postSource: json["post_source"] == null ? null : PostSource.fromJson(json["post_source"]),
        comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
        likes: json["likes"] == null ? null : WallLikes.fromJson(json["likes"]),
        reposts: json["reposts"] == null ? null : Reposts.fromJson(json["reposts"]),
        views: json["views"] == null ? null : Views.fromJson(json["views"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
        accessKey: json["access_key"] == null ? null : json["access_key"],
        copyright: json["copyright"] == null ? null : Copyright.fromJson(json["copyright"]),
        signerId: json["signer_id"] == null ? null : json["signer_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "from_id": fromId == null ? null : fromId,
        "to_id": toId == null ? null : toId,
        "date": date == null ? null : date,
        "post_type": postType == null ? null : postTypeValues.reverse[postType],
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
        "copyright": copyright == null ? null : copyright.toJson(),
        "signer_id": signerId == null ? null : signerId,
    };
}

class WallAttachment {
    WallAttachment({
        this.type,
        this.photo,
        this.doc,
        this.video,
        this.link,
        this.poll,
    });

    final AttachmentType type;
    final LinkPhoto photo;
    final FluffyDoc doc;
    final Video video;
    final FluffyLink link;
    final Poll poll;

    factory WallAttachment.fromRawJson(String str) => WallAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallAttachment.fromJson(Map<String, dynamic> json) => WallAttachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
        doc: json["doc"] == null ? null : FluffyDoc.fromJson(json["doc"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        link: json["link"] == null ? null : FluffyLink.fromJson(json["link"]),
        poll: json["poll"] == null ? null : Poll.fromJson(json["poll"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "photo": photo == null ? null : photo.toJson(),
        "doc": doc == null ? null : doc.toJson(),
        "video": video == null ? null : video.toJson(),
        "link": link == null ? null : link.toJson(),
        "poll": poll == null ? null : poll.toJson(),
    };
}

class FluffyDoc {
    FluffyDoc({
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
    final FluffyPreview preview;
    final String accessKey;

    factory FluffyDoc.fromRawJson(String str) => FluffyDoc.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FluffyDoc.fromJson(Map<String, dynamic> json) => FluffyDoc(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        title: json["title"] == null ? null : json["title"],
        size: json["size"] == null ? null : json["size"],
        ext: json["ext"] == null ? null : json["ext"],
        date: json["date"] == null ? null : json["date"],
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
        preview: json["preview"] == null ? null : FluffyPreview.fromJson(json["preview"]),
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

class FluffyPreview {
    FluffyPreview({
        this.photo,
        this.video,
    });

    final PreviewPhoto photo;
    final Size video;

    factory FluffyPreview.fromRawJson(String str) => FluffyPreview.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FluffyPreview.fromJson(Map<String, dynamic> json) => FluffyPreview(
        photo: json["photo"] == null ? null : PreviewPhoto.fromJson(json["photo"]),
        video: json["video"] == null ? null : Size.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "photo": photo == null ? null : photo.toJson(),
        "video": video == null ? null : video.toJson(),
    };
}

class FluffyLink {
    FluffyLink({
        this.url,
        this.title,
        this.caption,
        this.description,
        this.photo,
        this.isFavorite,
        this.button,
        this.target,
    });

    final String url;
    final String title;
    final String caption;
    final String description;
    final LinkPhoto photo;
    final bool isFavorite;
    final Button button;
    final String target;

    factory FluffyLink.fromRawJson(String str) => FluffyLink.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FluffyLink.fromJson(Map<String, dynamic> json) => FluffyLink(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        caption: json["caption"] == null ? null : json["caption"],
        description: json["description"] == null ? null : json["description"],
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"],
        button: json["button"] == null ? null : Button.fromJson(json["button"]),
        target: json["target"] == null ? null : json["target"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "caption": caption == null ? null : caption,
        "description": description == null ? null : description,
        "photo": photo == null ? null : photo.toJson(),
        "is_favorite": isFavorite == null ? null : isFavorite,
        "button": button == null ? null : button.toJson(),
        "target": target == null ? null : target,
    };
}

class Button {
    Button({
        this.title,
        this.action,
    });

    final String title;
    final Action action;

    factory Button.fromRawJson(String str) => Button.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Button.fromJson(Map<String, dynamic> json) => Button(
        title: json["title"] == null ? null : json["title"],
        action: json["action"] == null ? null : Action.fromJson(json["action"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "action": action == null ? null : action.toJson(),
    };
}

class Action {
    Action({
        this.type,
        this.url,
    });

    final String type;
    final String url;

    factory Action.fromRawJson(String str) => Action.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Action.fromJson(Map<String, dynamic> json) => Action(
        type: json["type"] == null ? null : json["type"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "url": url == null ? null : url,
    };
}

class Poll {
    Poll({
        this.anonymous,
        this.multiple,
        this.endDate,
        this.closed,
        this.isBoard,
        this.canEdit,
        this.canVote,
        this.canReport,
        this.canShare,
        this.created,
        this.id,
        this.ownerId,
        this.question,
        this.votes,
        this.disableUnvote,
        this.answerIds,
        this.answers,
        this.authorId,
        this.background,
    });

    final bool anonymous;
    final bool multiple;
    final int endDate;
    final bool closed;
    final bool isBoard;
    final bool canEdit;
    final bool canVote;
    final bool canReport;
    final bool canShare;
    final int created;
    final int id;
    final int ownerId;
    final String question;
    final int votes;
    final bool disableUnvote;
    final List<dynamic> answerIds;
    final List<Answer> answers;
    final int authorId;
    final Background background;

    factory Poll.fromRawJson(String str) => Poll.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        anonymous: json["anonymous"] == null ? null : json["anonymous"],
        multiple: json["multiple"] == null ? null : json["multiple"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        closed: json["closed"] == null ? null : json["closed"],
        isBoard: json["is_board"] == null ? null : json["is_board"],
        canEdit: json["can_edit"] == null ? null : json["can_edit"],
        canVote: json["can_vote"] == null ? null : json["can_vote"],
        canReport: json["can_report"] == null ? null : json["can_report"],
        canShare: json["can_share"] == null ? null : json["can_share"],
        created: json["created"] == null ? null : json["created"],
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        question: json["question"] == null ? null : json["question"],
        votes: json["votes"] == null ? null : json["votes"],
        disableUnvote: json["disable_unvote"] == null ? null : json["disable_unvote"],
        answerIds: json["answer_ids"] == null ? null : List<dynamic>.from(json["answer_ids"].map((x) => x)),
        answers: json["answers"] == null ? null : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        authorId: json["author_id"] == null ? null : json["author_id"],
        background: json["background"] == null ? null : Background.fromJson(json["background"]),
    );

    Map<String, dynamic> toJson() => {
        "anonymous": anonymous == null ? null : anonymous,
        "multiple": multiple == null ? null : multiple,
        "end_date": endDate == null ? null : endDate,
        "closed": closed == null ? null : closed,
        "is_board": isBoard == null ? null : isBoard,
        "can_edit": canEdit == null ? null : canEdit,
        "can_vote": canVote == null ? null : canVote,
        "can_report": canReport == null ? null : canReport,
        "can_share": canShare == null ? null : canShare,
        "created": created == null ? null : created,
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "question": question == null ? null : question,
        "votes": votes == null ? null : votes,
        "disable_unvote": disableUnvote == null ? null : disableUnvote,
        "answer_ids": answerIds == null ? null : List<dynamic>.from(answerIds.map((x) => x)),
        "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
        "author_id": authorId == null ? null : authorId,
        "background": background == null ? null : background.toJson(),
    };
}

class Answer {
    Answer({
        this.id,
        this.rate,
        this.text,
        this.votes,
    });

    final int id;
    final double rate;
    final String text;
    final int votes;

    factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"] == null ? null : json["id"],
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        text: json["text"] == null ? null : json["text"],
        votes: json["votes"] == null ? null : json["votes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "rate": rate == null ? null : rate,
        "text": text == null ? null : text,
        "votes": votes == null ? null : votes,
    };
}

class Background {
    Background({
        this.angle,
        this.color,
        this.id,
        this.name,
        this.points,
        this.type,
    });

    final int angle;
    final String color;
    final int id;
    final String name;
    final List<Point> points;
    final String type;

    factory Background.fromRawJson(String str) => Background.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Background.fromJson(Map<String, dynamic> json) => Background(
        angle: json["angle"] == null ? null : json["angle"],
        color: json["color"] == null ? null : json["color"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        points: json["points"] == null ? null : List<Point>.from(json["points"].map((x) => Point.fromJson(x))),
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "angle": angle == null ? null : angle,
        "color": color == null ? null : color,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "points": points == null ? null : List<dynamic>.from(points.map((x) => x.toJson())),
        "type": type == null ? null : type,
    };
}

class Point {
    Point({
        this.color,
        this.position,
    });

    final String color;
    final int position;

    factory Point.fromRawJson(String str) => Point.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Point.fromJson(Map<String, dynamic> json) => Point(
        color: json["color"] == null ? null : json["color"],
        position: json["position"] == null ? null : json["position"],
    );

    Map<String, dynamic> toJson() => {
        "color": color == null ? null : color,
        "position": position == null ? null : position,
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

class Copyright {
    Copyright({
        this.id,
        this.link,
        this.type,
        this.name,
    });

    final int id;
    final String link;
    final String type;
    final String name;

    factory Copyright.fromRawJson(String str) => Copyright.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Copyright.fromJson(Map<String, dynamic> json) => Copyright(
        id: json["id"] == null ? null : json["id"],
        link: json["link"] == null ? null : json["link"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "link": link == null ? null : link,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
    };
}

class WallLikes {
    WallLikes({
        this.count,
        this.userLikes,
        this.canLike,
        this.canPublish,
    });

    final int count;
    final int userLikes;
    final int canLike;
    final int canPublish;

    factory WallLikes.fromRawJson(String str) => WallLikes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallLikes.fromJson(Map<String, dynamic> json) => WallLikes(
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
        this.platform,
        this.data,
    });

    final PostSourceType type;
    final String platform;
    final String data;

    factory PostSource.fromRawJson(String str) => PostSource.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PostSource.fromJson(Map<String, dynamic> json) => PostSource(
        type: json["type"] == null ? null : postSourceTypeValues.map[json["type"]],
        platform: json["platform"] == null ? null : json["platform"],
        data: json["data"] == null ? null : json["data"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : postSourceTypeValues.reverse[type],
        "platform": platform == null ? null : platform,
        "data": data == null ? null : data,
    };
}

enum PostSourceType { VK, API }

final postSourceTypeValues = EnumValues({
    "api": PostSourceType.API,
    "vk": PostSourceType.VK
});

enum PostType { POST }

final postTypeValues = EnumValues({
    "post": PostType.POST
});

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

class WallReply {
    WallReply({
        this.id,
        this.fromId,
        this.postId,
        this.ownerId,
        this.parentsStack,
        this.date,
        this.text,
        this.likes,
        this.thread,
        this.replyToUser,
        this.replyToComment,
        this.attachments,
    });

    final int id;
    final int fromId;
    final int postId;
    final int ownerId;
    final List<int> parentsStack;
    final int date;
    final String text;
    final WallReplyLikes likes;
    final Views thread;
    final int replyToUser;
    final int replyToComment;
    final List<WallReplyAttachment> attachments;

    factory WallReply.fromRawJson(String str) => WallReply.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallReply.fromJson(Map<String, dynamic> json) => WallReply(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        parentsStack: json["parents_stack"] == null ? null : List<int>.from(json["parents_stack"].map((x) => x)),
        date: json["date"] == null ? null : json["date"],
        text: json["text"] == null ? null : json["text"],
        likes: json["likes"] == null ? null : WallReplyLikes.fromJson(json["likes"]),
        thread: json["thread"] == null ? null : Views.fromJson(json["thread"]),
        replyToUser: json["reply_to_user"] == null ? null : json["reply_to_user"],
        replyToComment: json["reply_to_comment"] == null ? null : json["reply_to_comment"],
        attachments: json["attachments"] == null ? null : List<WallReplyAttachment>.from(json["attachments"].map((x) => WallReplyAttachment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "from_id": fromId == null ? null : fromId,
        "post_id": postId == null ? null : postId,
        "owner_id": ownerId == null ? null : ownerId,
        "parents_stack": parentsStack == null ? null : List<dynamic>.from(parentsStack.map((x) => x)),
        "date": date == null ? null : date,
        "text": text == null ? null : text,
        "likes": likes == null ? null : likes.toJson(),
        "thread": thread == null ? null : thread.toJson(),
        "reply_to_user": replyToUser == null ? null : replyToUser,
        "reply_to_comment": replyToComment == null ? null : replyToComment,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
    };
}

class WallReplyAttachment {
    WallReplyAttachment({
        this.type,
        this.doc,
        this.photo,
    });

    final AttachmentType type;
    final FluffyDoc doc;
    final LinkPhoto photo;

    factory WallReplyAttachment.fromRawJson(String str) => WallReplyAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallReplyAttachment.fromJson(Map<String, dynamic> json) => WallReplyAttachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        doc: json["doc"] == null ? null : FluffyDoc.fromJson(json["doc"]),
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "doc": doc == null ? null : doc.toJson(),
        "photo": photo == null ? null : photo.toJson(),
    };
}

class WallReplyLikes {
    WallReplyLikes({
        this.count,
        this.userLikes,
        this.canLike,
        this.canPublish,
    });

    final int count;
    final int userLikes;
    final int canLike;
    final bool canPublish;

    factory WallReplyLikes.fromRawJson(String str) => WallReplyLikes.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallReplyLikes.fromJson(Map<String, dynamic> json) => WallReplyLikes(
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

class FwdMessage {
    FwdMessage({
        this.date,
        this.fromId,
        this.text,
        this.attachments,
        this.conversationMessageId,
        this.peerId,
        this.id,
    });

    final int date;
    final int fromId;
    final String text;
    final List<FwdMessageAttachment> attachments;
    final int conversationMessageId;
    final int peerId;
    final int id;

    factory FwdMessage.fromRawJson(String str) => FwdMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FwdMessage.fromJson(Map<String, dynamic> json) => FwdMessage(
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        text: json["text"] == null ? null : json["text"],
        attachments: json["attachments"] == null ? null : List<FwdMessageAttachment>.from(json["attachments"].map((x) => FwdMessageAttachment.fromJson(x))),
        conversationMessageId: json["conversation_message_id"] == null ? null : json["conversation_message_id"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "from_id": fromId == null ? null : fromId,
        "text": text == null ? null : text,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
        "conversation_message_id": conversationMessageId == null ? null : conversationMessageId,
        "peer_id": peerId == null ? null : peerId,
        "id": id == null ? null : id,
    };
}

class FwdMessageAttachment {
    FwdMessageAttachment({
        this.type,
        this.photo,
    });

    final AttachmentType type;
    final LinkPhoto photo;

    factory FwdMessageAttachment.fromRawJson(String str) => FwdMessageAttachment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FwdMessageAttachment.fromJson(Map<String, dynamic> json) => FwdMessageAttachment(
        type: json["type"] == null ? null : attachmentTypeValues.map[json["type"]],
        photo: json["photo"] == null ? null : LinkPhoto.fromJson(json["photo"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : attachmentTypeValues.reverse[type],
        "photo": photo == null ? null : photo.toJson(),
    };
}

enum Ref { SINGLE, CLUB_83515968, FEED_RECENT, CLUB_40232010 }

final refValues = EnumValues({
    "club-40232010": Ref.CLUB_40232010,
    "club-83515968": Ref.CLUB_83515968,
    "feed_recent": Ref.FEED_RECENT,
    "single": Ref.SINGLE
});

class OnlineInfo {
    OnlineInfo({
        this.visible,
        this.lastSeen,
        this.isOnline,
        this.isMobile,
        this.appId,
    });

    final bool visible;
    final int lastSeen;
    final bool isOnline;
    final bool isMobile;
    final int appId;

    factory OnlineInfo.fromRawJson(String str) => OnlineInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OnlineInfo.fromJson(Map<String, dynamic> json) => OnlineInfo(
        visible: json["visible"] == null ? null : json["visible"],
        lastSeen: json["last_seen"] == null ? null : json["last_seen"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
        appId: json["app_id"] == null ? null : json["app_id"],
    );

    Map<String, dynamic> toJson() => {
        "visible": visible == null ? null : visible,
        "last_seen": lastSeen == null ? null : lastSeen,
        "is_online": isOnline == null ? null : isOnline,
        "is_mobile": isMobile == null ? null : isMobile,
        "app_id": appId == null ? null : appId,
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
