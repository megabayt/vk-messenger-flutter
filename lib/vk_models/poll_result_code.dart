import 'package:vk_messenger_flutter/utils/enum_values.dart';

enum VkPollResultCode {
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

final vkPollResultCodeValues = EnumValues({
  1: VkPollResultCode.CHANGE_MSG_FLAG,
  2: VkPollResultCode.SET_MSG_FLAG,
  3: VkPollResultCode.RESET_MSG_FLAG,
  4: VkPollResultCode.ADD_MSG,
  5: VkPollResultCode.EDIT_MSG,
  6: VkPollResultCode.READ_IN_MSG,
  7: VkPollResultCode.READ_OUT_MSG,
  8: VkPollResultCode.FRIEND_ONLINE,
  9: VkPollResultCode.FRIEND_OFFLINE,
  10: VkPollResultCode.RESET_PEER_FLAGS,
  11: VkPollResultCode.CHANGE_PEER_FLAGS,
  12: VkPollResultCode.SET_PEER_FLAGS,
  13: VkPollResultCode.REMOVE_MSG,
  14: VkPollResultCode.RESTORE_MSG,
  20: VkPollResultCode.CHANGE_MAJOR,
  21: VkPollResultCode.CHANGE_MINOR,
  51: VkPollResultCode.CHANGE_CHAT_MEMBERS_OR_TOPIC,
  52: VkPollResultCode.CHANGE_CHAT,
  61: VkPollResultCode.USER_TYPING_DIALOG,
  62: VkPollResultCode.USER_TYPING_CHAT,
  63: VkPollResultCode.USERS_TYPING_CHAT,
  64: VkPollResultCode.USERS_RECORD_VOICE_CHAT,
  70: VkPollResultCode.USER_CALL,
  80: VkPollResultCode.MENU_COUNT,
  114: VkPollResultCode.NOTIF_CHANGE,
});
