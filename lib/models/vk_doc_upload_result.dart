import 'package:meta/meta.dart';
import 'dart:convert';

VkDocUploadResult vkDocUploadResultFromJson(String str) =>
    VkDocUploadResult.fromJson(json.decode(str));

String vkDocUploadResultToJson(VkDocUploadResult data) =>
    json.encode(data.toJson());

class VkDocUploadResult {
  VkDocUploadResult({
    @required this.file,
  });

  final String file;

  factory VkDocUploadResult.fromJson(Map<String, dynamic> json) =>
      VkDocUploadResult(
        file: json["file"] == null ? null : json["file"],
      );

  Map<String, dynamic> toJson() => {
        "file": file == null ? null : file,
      };
}
