import 'dart:convert';

class Gift {
    Gift({
        this.id,
        this.thumb256,
        this.thumb48,
        this.thumb96,
    });

    final int id;
    final String thumb256;
    final String thumb48;
    final String thumb96;

    factory Gift.fromRawJson(String str) => Gift.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"] == null ? null : json["id"],
        thumb256: json["thumb_256"] == null ? null : json["thumb_256"],
        thumb48: json["thumb_48"] == null ? null : json["thumb_48"],
        thumb96: json["thumb_96"] == null ? null : json["thumb_96"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "thumb_256": thumb256 == null ? null : thumb256,
        "thumb_48": thumb48 == null ? null : thumb48,
        "thumb_96": thumb96 == null ? null : thumb96,
    };
}