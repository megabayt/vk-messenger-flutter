class VkIcon {
  VkIcon({
    this.url,
    this.width,
    this.height,
  });

  final String url;
  final int width;
  final int height;

  factory VkIcon.fromMap(Map<String, dynamic> json) => VkIcon(
        url: json["url"] == null ? null : json["url"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
      );
}
