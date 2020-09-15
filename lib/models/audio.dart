import 'dart:convert';

class Audio {
  Audio({
    this.id,
    this.ownerId,
    this.artist,
    this.title,
    this.url,
    this.contentRestricted,
  });

  final int id;
  final int ownerId;
  final String artist;
  final String title;
  final String url;
  final int contentRestricted;

  factory Audio.fromRawJson(String str) => Audio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        artist: json["artist"] == null ? null : json["artist"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        contentRestricted: json["content_restricted"] == null
            ? null
            : json["content_restricted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "owner_id": ownerId == null ? null : ownerId,
        "artist": artist == null ? null : artist,
        "title": title == null ? null : title,
        "url": url == null ? null : url,
        "content_restricted":
            contentRestricted == null ? null : contentRestricted,
      };
}
