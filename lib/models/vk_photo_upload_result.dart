import 'package:meta/meta.dart';
import 'dart:convert';

VkPhotoUploadResult vkPhotoUploadResultFromJson(String str) => VkPhotoUploadResult.fromJson(json.decode(str));

String vkPhotoUploadResultToJson(VkPhotoUploadResult data) => json.encode(data.toJson());

class VkPhotoUploadResult {
    VkPhotoUploadResult({
        @required this.server,
        @required this.photo,
        @required this.hash,
    });

    final int server;
    final String photo;
    final String hash;

    factory VkPhotoUploadResult.fromJson(Map<String, dynamic> json) => VkPhotoUploadResult(
        server: json["server"] == null ? null : json["server"],
        photo: json["photo"] == null ? null : json["photo"],
        hash: json["hash"] == null ? null : json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "server": server == null ? null : server,
        "photo": photo == null ? null : photo,
        "hash": hash == null ? null : hash,
    };
}
