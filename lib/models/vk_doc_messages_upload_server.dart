import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/upload_server.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkDocMessagesUploadServerResponseBody {
  VkDocMessagesUploadServerResponseBody({
    @required this.response,
    this.error,
  });

  final UploadServer response;
  final VkError error;

  factory VkDocMessagesUploadServerResponseBody.fromJson(Map<String, dynamic> json) =>
      VkDocMessagesUploadServerResponseBody(
        response: json["response"] == null
            ? null
            : UploadServer.fromJson(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}
