import 'package:vk_messenger_flutter/vk_models/peer_type.dart';
import 'package:vk_messenger_flutter/vk_models/profile.dart';

class Profile {
  final int id;
  final String avatar;
  final String name;
  final VkPeerType type;
  final bool isOnline;

  const Profile({
    this.id,
    this.avatar,
    this.name,
    this.type,
    this.isOnline,
  });

  factory Profile.fromVkProfile(VkProfile vkProfile, [bool isGroup = false]) => Profile(
        id: !isGroup ? vkProfile?.id : -vkProfile?.id,
        avatar: vkProfile?.photo50,
        name: !isGroup
            ? '${vkProfile?.firstName} ${vkProfile?.lastName}'
            : vkProfile?.name,
        type: !isGroup ? VkPeerType.USER : VkPeerType.GROUP,
        isOnline: vkProfile?.online == 1,
      );

  Profile copyWith({
    int id,
    String avatar,
    String name,
    VkPeerType type,
    bool isOnline,
  }) =>
      Profile(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        type: type ?? this.type,
        isOnline: isOnline ?? this.isOnline,
      );
}
