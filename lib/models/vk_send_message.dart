import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkSendMessageResponseBody {
  VkSendMessageResponseBody({
    @required this.response,
    this.error,
  });

  final int response;
  final VkError error;

  factory VkSendMessageResponseBody.fromJson(Map<String, dynamic> json) =>
      VkSendMessageResponseBody(
        response: json["response"] == null ? null : json["response"],
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response,
        "error": error == null ? null : error.toJson(),
      };
}
