import 'dart:convert';

class WallReply {
    WallReply({
        this.id,
        this.fromId,
        this.postId,
        this.ownerId,
        this.text,
    });

    final int id;
    final int fromId;
    final int postId;
    final int ownerId;
    final String text;

    factory WallReply.fromRawJson(String str) => WallReply.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WallReply.fromJson(Map<String, dynamic> json) => WallReply(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        text: json["text"] == null ? null : json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "from_id": fromId == null ? null : fromId,
        "post_id": postId == null ? null : postId,
        "owner_id": ownerId == null ? null : ownerId,
        "text": text == null ? null : text,
    };
}
