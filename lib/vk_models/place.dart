class VkPlace {
  VkPlace({
    this.country,
    this.city,
    this.title,
  });

  final String country;
  final String city;
  final String title;

  factory VkPlace.fromMap(Map<String, dynamic> json) => VkPlace(
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        title: json["title"] == null ? null : json["title"],
      );
}
