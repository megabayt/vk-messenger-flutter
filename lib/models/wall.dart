import 'dart:convert';

class Wall {
    Wall({
        this.id,
        this.fromId,
        this.toId,
        this.text,
    });

    final int id;
    final int fromId;
    final int toId;
    final String text;

    factory Wall.fromRawJson(String str) => Wall.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wall.fromJson(Map<String, dynamic> json) => Wall(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        toId: json["to_id"] == null ? null : json["to_id"],
        text: json["text"] == null ? null : json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "from_id": fromId == null ? null : fromId,
        "to_id": toId == null ? null : toId,
        "text": text == null ? null : text,
    };
}