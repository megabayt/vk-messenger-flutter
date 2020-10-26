import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/models/coordinates.dart';
import 'package:vk_messenger_flutter/models/place.dart';

class Geo {
    Geo({
        @required this.type,
        @required this.coordinates,
        @required this.place,
    });

    final String type;
    final Coordinates coordinates;
    final Place place;

    factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null ? null : coordinates.toJson(),
        "place": place == null ? null : place.toJson(),
    };
}