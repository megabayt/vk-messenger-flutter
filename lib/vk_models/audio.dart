class VkAudio {
  VkAudio({
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

  factory VkAudio.fromMap(Map<String, dynamic> json) => VkAudio(
        id: json["id"] == null ? null : json["id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        artist: json["artist"] == null ? null : json["artist"],
        title: json["title"] == null ? null : json["title"],
        url: json["url"] == null ? null : json["url"],
        contentRestricted: json["content_restricted"] == null
            ? null
            : json["content_restricted"],
      );
}
