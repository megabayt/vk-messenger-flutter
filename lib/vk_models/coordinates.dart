class VkCoordinates {
  VkCoordinates({
    this.latitude,
    this.longitude,
  });

  final double latitude;
  final double longitude;

  factory VkCoordinates.fromMap(Map<String, dynamic> json) => VkCoordinates(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );
}
