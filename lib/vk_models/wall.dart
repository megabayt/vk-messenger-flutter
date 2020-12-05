class VkWall {
  VkWall({
    this.id,
    this.fromId,
    this.toId,
    this.text,
  });

  final int id;
  final int fromId;
  final int toId;
  final String text;

  factory VkWall.fromMap(Map<String, dynamic> json) => VkWall(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        toId: json["to_id"] == null ? null : json["to_id"],
        text: json["text"] == null ? null : json["text"],
      );
}
