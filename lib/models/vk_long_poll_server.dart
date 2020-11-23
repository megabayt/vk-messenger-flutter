import 'package:vk_messenger_flutter/models/long_poll_server.dart';

class VkLongPollServer {
  VkLongPollServer({
    this.response,
  });

  final LongPollServer response;

  factory VkLongPollServer.fromJson(Map<String, dynamic> json) =>
      VkLongPollServer(
        response: json["response"] == null
            ? null
            : LongPollServer.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
      };
}
