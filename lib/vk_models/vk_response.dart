import 'package:vk_messenger_flutter/vk_models/vk_error.dart';

class VkResponse<T> {
  VkResponse({
    this.response,
    this.error,
  });

  final T response;
  final VkError error;

  factory VkResponse.fromMap(Map<String, dynamic> json, T response) =>
      VkResponse(
        response: response,
        error: json["error"] == null ? null : VkError.fromMap(json["error"]),
      );
}
