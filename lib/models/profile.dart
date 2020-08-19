import 'dart:convert';

class Profile {
    Profile({
        this.id,
        this.firstName,
        this.lastName,
        this.photo50,
        this.photo100,
        this.online,
        this.onlineInfo,
    });

    final int id;
    final String firstName;
    final String lastName;
    final String photo50;
    final String photo100;
    final int online;
    final OnlineInfo onlineInfo;

    factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        photo50: json["photo_50"] == null ? null : json["photo_50"],
        photo100: json["photo_100"] == null ? null : json["photo_100"],
        online: json["online"] == null ? null : json["online"],
        onlineInfo: json["online_info"] == null ? null : OnlineInfo.fromJson(json["online_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "photo_50": photo50 == null ? null : photo50,
        "photo_100": photo100 == null ? null : photo100,
        "online": online == null ? null : online,
        "online_info": onlineInfo == null ? null : onlineInfo.toJson(),
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
