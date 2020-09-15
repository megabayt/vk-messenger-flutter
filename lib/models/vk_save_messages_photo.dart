import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/photo.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkSaveMessagesPhoto {
  VkSaveMessagesPhoto({
    @required this.response,
    this.error,
  });

  final Photo response;
  final VkError error;

  factory VkSaveMessagesPhoto.fromJson(Map<String, dynamic> json) =>
      VkSaveMessagesPhoto(
        response: json["response"] != null &&
                json["response"] is List<dynamic> &&
                json["response"].length > 0
            ? Photo.fromJson(json["response"][0])
            : null,
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}
