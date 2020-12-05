import 'package:vk_messenger_flutter/utils/enum_values.dart';

enum VkPeerType { USER, GROUP, CHAT }

final vkPeerTypeValues = EnumValues({
  "user": VkPeerType.USER,
  "group": VkPeerType.GROUP,
  "chat": VkPeerType.CHAT,
});
