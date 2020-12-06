import 'package:vk_messenger_flutter/vk_models/poll_result_code.dart';

class VkPollResutUpdateItem {
  final VkPollResultCode code;
  final dynamic field1;
  final dynamic field2;
  final dynamic field3;
  final dynamic field4;
  final dynamic field5;
  final dynamic field6;

  VkPollResutUpdateItem(
    this.code, [
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
  ]);

  factory VkPollResutUpdateItem.fromMap(List<dynamic> json) => json == null
      ? VkPollResutUpdateItem(null)
      : VkPollResutUpdateItem(
          json.length <= 0 ? null : vkPollResultCodeValues.map[json[0]],
          json.length <= 1 ? null : json[1],
          json.length <= 2 ? null : json[2],
          json.length <= 3 ? null : json[3],
          json.length <= 4 ? null : json[4],
          json.length <= 5 ? null : json[5],
          json.length <= 6 ? null : json[6],
        );
}
