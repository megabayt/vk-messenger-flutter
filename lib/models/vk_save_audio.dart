import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/audio.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkSaveAudio {
  VkSaveAudio({
    @required this.response,
    this.error,
  });

  final Audio response;
  final VkError error;

  factory VkSaveAudio.fromJson(Map<String, dynamic> json) =>
      VkSaveAudio(
        response: json["response"] == null
            ? null
            : Audio.fromJson(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}
