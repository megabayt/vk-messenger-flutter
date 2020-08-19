import 'package:vk_messenger_flutter/models/group.dart';
import 'package:vk_messenger_flutter/models/profile.dart';

class ProfileCacheItem {
  String _avatar;
  String _name;

  ProfileCacheItem(this._avatar, this._name);

  get avatar {
    return this._avatar;
  }

  get name {
    return this._name;
  }
}

abstract class ProfilesService {
  ProfileCacheItem getProfile(int peerId);
  void appendProfiles(List<Profile> newProfiles);
  void appendGroups(List<Group> newGroups);
}
