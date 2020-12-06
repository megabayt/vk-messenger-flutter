class VkChatSettings {
  VkChatSettings({
    this.activeIds,
    this.title,
  });

  final List<int> activeIds;
  final String title;

  factory VkChatSettings.fromMap(Map<String, dynamic> json) => VkChatSettings(
        activeIds: json["active_ids"] == null
            ? null
            : List<int>.from(json["active_ids"].map((x) => x)),
        title: json["title"] == null ? null : json["title"],
      );
}
