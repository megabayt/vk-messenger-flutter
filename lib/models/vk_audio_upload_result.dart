import 'package:meta/meta.dart';
import 'dart:convert';

VkAudioUploadResult vkAudioUploadResultFromJson(String str) =>
    VkAudioUploadResult.fromJson(json.decode(str));

String vkAudioUploadResultToJson(VkAudioUploadResult data) =>
    json.encode(data.toJson());

class VkAudioUploadResult {
  VkAudioUploadResult({
    @required this.server,
    @required this.audio,
    @required this.redirect,
    @required this.hash,
  });

  final int server;
  final String audio;
  final String redirect;
  final String hash;

  factory VkAudioUploadResult.fromJson(Map<String, dynamic> json) =>
      VkAudioUploadResult(
        server: json["server"] == null ? null : json["server"],
        audio: json["audio"] == null ? null : json["audio"],
        redirect: json["redirect"] == null ? null : json["redirect"],
        hash: json["hash"] == null ? null : json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "server": server == null ? null : server,
        "audio": audio == null ? null : audio,
        "redirect": redirect == null ? null : redirect,
        "hash": hash == null ? null : hash,
      };
}
