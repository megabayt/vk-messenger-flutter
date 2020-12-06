import 'package:vk_messenger_flutter/vk_models/coordinates.dart';
import 'package:vk_messenger_flutter/vk_models/place.dart';

class VkGeo {
  VkGeo({
    this.type,
    this.coordinates,
    this.place,
  });

  final String type;
  final VkCoordinates coordinates;
  final VkPlace place;

  factory VkGeo.fromMap(Map<String, dynamic> json) => VkGeo(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : VkCoordinates.fromMap(json["coordinates"]),
        place: json["place"] == null ? null : VkPlace.fromMap(json["place"]),
      );
}
