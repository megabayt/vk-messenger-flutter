import 'package:flutter/material.dart';

class Place {
    Place({
        @required this.country,
        @required this.city,
        @required this.title,
    });

    final String country;
    final String city;
    final String title;

    factory Place.fromJson(Map<String, dynamic> json) => Place(
        country: json["country"] == null ? null : json["country"],
        city: json["city"] == null ? null : json["city"],
        title: json["title"] == null ? null : json["title"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "city": city == null ? null : city,
        "title": title == null ? null : title,
    };
}