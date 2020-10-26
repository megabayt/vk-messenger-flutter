import 'package:flutter/material.dart';

class Icon {
    Icon({
        @required this.url,
        @required this.width,
        @required this.height,
    });

    final String url;
    final int width;
    final int height;

    factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        url: json["url"] == null ? null : json["url"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
    };
}
