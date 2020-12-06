import 'package:vk_messenger_flutter/vk_models/poll_result_update_item.dart';

class VkPollResult {
  VkPollResult({
    this.ts,
    this.updates,
    this.failed,
  });

  final int ts;
  final List<VkPollResutUpdateItem> updates;
  final int failed;

  factory VkPollResult.fromMap(Map<String, dynamic> json) => VkPollResult(
        ts: json["ts"] == null ? null : json["ts"],
        updates: json["updates"] == null
            ? null
            : List<VkPollResutUpdateItem>.from(
                json["updates"].map(
                  (x) => x == null ? null : VkPollResutUpdateItem.fromMap(x),
                ),
              ),
        failed: json["failed"] == null ? null : json["failed"],
      );
}
