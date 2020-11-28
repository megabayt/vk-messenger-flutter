import 'package:vk_messenger_flutter/models/group.dart';
import 'package:vk_messenger_flutter/models/profile.dart';

class ProfileCacheItem {
  final String avatar;
  final String name;
  final bool isOnline;

  const ProfileCacheItem({this.avatar, this.name, this.isOnline});

  ProfileCacheItem copyWith({
    String avatar,
    String name,
    bool isOnline,
  }) =>
      ProfileCacheItem(
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        isOnline: isOnline ?? this.isOnline,
      );
}

abstract class ProfilesService {
  ProfileCacheItem getProfile(int peerId);
  void appendProfiles(List<Profile> newProfiles);
  void appendGroups(List<Group> newGroups);
  void setOnline(int profileId, bool isOnline);
}
