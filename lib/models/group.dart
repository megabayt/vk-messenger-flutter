import 'dart:convert';

class Group {
    Group({
        this.id,
        this.name,
        this.photo50,
        this.photo100,
        this.photo200,
    });

    final int id;
    final String name;
    final String photo50;
    final String photo100;
    final String photo200;

    factory Group.fromRawJson(String str) => Group.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo50: json["photo_50"] == null ? null : json["photo_50"],
        photo100: json["photo_100"] == null ? null : json["photo_100"],
        photo200: json["photo_200"] == null ? null : json["photo_200"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo_50": photo50 == null ? null : photo50,
        "photo_100": photo100 == null ? null : photo100,
        "photo_200": photo200 == null ? null : photo200,
    };
}
