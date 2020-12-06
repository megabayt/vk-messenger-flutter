class VkOnlineInfo {
  VkOnlineInfo({
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

  factory VkOnlineInfo.fromMap(Map<String, dynamic> json) => VkOnlineInfo(
        visible: json["visible"] == null ? null : json["visible"],
        lastSeen: json["last_seen"] == null ? null : json["last_seen"],
        isOnline: json["is_online"] == null ? null : json["is_online"],
        appId: json["app_id"] == null ? null : json["app_id"],
        isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
      );
}
