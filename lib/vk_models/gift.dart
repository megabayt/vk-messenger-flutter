class VkGift {
  VkGift({
    this.id,
    this.thumb256,
    this.thumb48,
    this.thumb96,
  });

  final int id;
  final String thumb256;
  final String thumb48;
  final String thumb96;

  factory VkGift.fromMap(Map<String, dynamic> json) => VkGift(
        id: json["id"] == null ? null : json["id"],
        thumb256: json["thumb_256"] == null ? null : json["thumb_256"],
        thumb48: json["thumb_48"] == null ? null : json["thumb_48"],
        thumb96: json["thumb_96"] == null ? null : json["thumb_96"],
      );
}
