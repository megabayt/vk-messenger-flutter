import 'package:vk_messenger_flutter/utils/enum_values.dart';

class PollResutUpdateItem {
  final PollResultCode code;
  final dynamic field1;
  final dynamic field2;
  final dynamic field3;
  final dynamic field4;
  final dynamic field5;
  final dynamic field6;

  PollResutUpdateItem(
    this.code, [
    this.field1,
    this.field2,
    this.field3,
    this.field4,
    this.field5,
    this.field6,
  ]);

  factory PollResutUpdateItem.fromJson(List<dynamic> json) => json == null
      ? PollResutUpdateItem(null)
      : PollResutUpdateItem(
          json.length <= 0 ? null : pollResultCodeValues.map[json[0]],
          json.length <= 1 ? null : json[1],
          json.length <= 2 ? null : json[2],
          json.length <= 3 ? null : json[3],
          json.length <= 4 ? null : json[4],
          json.length <= 5 ? null : json[5],
          json.length <= 6 ? null : json[6],
        );

  List<dynamic> toJson() => [
        code == null ? null : pollResultCodeValues.reverse[code],
        field1 == null ? null : field1,
        field2 == null ? null : field2,
        field3 == null ? null : field3,
        field4 == null ? null : field4,
        field5 == null ? null : field5,
        field6 == null ? null : field6,
      ];
}

enum PollResultCode {
  CHANGE_MSG_FLAG,
  SET_MSG_FLAG,
  RESET_MSG_FLAG,
  ADD_MSG,
  EDIT_MSG,
  READ_IN_MSG,
  READ_OUT_MSG,
  FRIEND_ONLINE,
  FRIEND_OFFLINE,
  RESET_PEER_FLAGS,
  CHANGE_PEER_FLAGS,
  SET_PEER_FLAGS,
  REMOVE_MSG,
  RESTORE_MSG,
  CHANGE_MAJOR,
  CHANGE_MINOR,
  CHANGE_CHAT_MEMBERS_OR_TOPIC,
  CHANGE_CHAT,
  USER_TYPING_DIALOG,
  USER_TYPING_CHAT,
  USERS_TYPING_CHAT,
  USERS_RECORD_VOICE_CHAT,
  USER_CALL,
  MENU_COUNT,
  NOTIF_CHANGE,
}

final pollResultCodeValues = EnumValues({
  1: PollResultCode.CHANGE_MSG_FLAG,
  2: PollResultCode.SET_MSG_FLAG,
  3: PollResultCode.RESET_MSG_FLAG,
  4: PollResultCode.ADD_MSG,
  5: PollResultCode.EDIT_MSG,
  6: PollResultCode.READ_IN_MSG,
  7: PollResultCode.READ_OUT_MSG,
  8: PollResultCode.FRIEND_ONLINE,
  9: PollResultCode.FRIEND_OFFLINE,
  10: PollResultCode.RESET_PEER_FLAGS,
  11: PollResultCode.CHANGE_PEER_FLAGS,
  12: PollResultCode.SET_PEER_FLAGS,
  13: PollResultCode.REMOVE_MSG,
  14: PollResultCode.RESTORE_MSG,
  20: PollResultCode.CHANGE_MAJOR,
  21: PollResultCode.CHANGE_MINOR,
  51: PollResultCode.CHANGE_CHAT_MEMBERS_OR_TOPIC,
  52: PollResultCode.CHANGE_CHAT,
  61: PollResultCode.USER_TYPING_DIALOG,
  62: PollResultCode.USER_TYPING_CHAT,
  63: PollResultCode.USERS_TYPING_CHAT,
  64: PollResultCode.USERS_RECORD_VOICE_CHAT,
  70: PollResultCode.USER_CALL,
  80: PollResultCode.MENU_COUNT,
  114: PollResultCode.NOTIF_CHANGE,
});
