import 'package:vk_messenger_flutter/models/poll_result_update_item.dart';

class PollResult {
  PollResult({
    this.ts,
    this.updates,
    this.failed,
  });

  final int ts;
  final List<PollResutUpdateItem> updates;
  final int failed;

  factory PollResult.fromJson(Map<String, dynamic> json) => PollResult(
        ts: json["ts"] == null ? null : json["ts"],
        updates: json["updates"] == null
            ? null
            : List<PollResutUpdateItem>.from(
                json["updates"].map(
                  (x) => x == null ? null : PollResutUpdateItem.fromJson(x),
                ),
              ),
        failed: json["failed"] == null ? null : json["failed"],
      );

  Map<String, dynamic> toJson() => {
        "ts": ts == null ? null : ts,
        "updates": updates == null
            ? null
            : List<List<dynamic>>.from(
                updates.map(
                  (x) => x == null
                      ? null
                      : List<dynamic>.from(
                          x.toJson(),
                        ),
                ),
              ),
        "failed": failed == null ? null : failed,
      };
}
