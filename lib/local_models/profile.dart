import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/vk_models/peer_type.dart';
import 'package:vk_messenger_flutter/vk_models/profile.dart';

part 'profile.g.dart';

@CopyWith()
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

  factory Profile.fromVkProfile(VkProfile vkProfile, [bool isGroup = false]) =>
      Profile(
        id: !isGroup ? vkProfile?.id : -vkProfile?.id,
        avatar: vkProfile?.photo50,
        name: !isGroup
            ? '${vkProfile?.firstName} ${vkProfile?.lastName}'
            : vkProfile?.name,
        type: !isGroup ? VkPeerType.USER : VkPeerType.GROUP,
        isOnline: vkProfile?.online == 1,
      );
}

extension ProfilesList on List<Profile> {
  Profile getById(int id) {
    final index = getIndexById(id);

    if (index == -1) {
      return null;
    }

    return this[index];
  }

  int getIndexById(int id) {
    return this.indexWhere((element) => element.id == id);
  }
}
