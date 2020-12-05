class VkWallReply {
  VkWallReply({
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

  factory VkWallReply.fromMap(Map<String, dynamic> json) => VkWallReply(
        id: json["id"] == null ? null : json["id"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        postId: json["post_id"] == null ? null : json["post_id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        text: json["text"] == null ? null : json["text"],
      );
}
