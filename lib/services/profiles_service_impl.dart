import 'package:vk_messenger_flutter/models/group.dart';
import 'package:vk_messenger_flutter/models/profile.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';

class ProfilesServiceImpl implements ProfilesService {
  List<Profile> _profiles = [];
  List<Group> _groups = [];
  final _cache = Map<int, ProfileCacheItem>();

  void appendProfiles(List<Profile> newProfiles) {
    if (newProfiles == null) {
      return;
    }
    _profiles.addAll(newProfiles);
  }

  void appendGroups(List<Group> newGroups) {
    if (newGroups == null) {
      return;
    }
    _groups.addAll(newGroups);
  }

  ProfileCacheItem getProfile(int peerId) {
    if (peerId == null) {
      return unknown;
    }

    if (_cache != null && _cache.containsKey(peerId)) {
      return _cache[peerId];
    }

    final profile = _profiles.firstWhere((profile) => profile.id == peerId,
        orElse: () => null);

    if (profile != null) {
      _cache[peerId] = ProfileCacheItem(
        avatar: profile.photo50,
        name: '${profile?.firstName} ${profile?.lastName}',
        isOnline: profile.online == 1,
      );
      return _cache[peerId];
    }

    final group =
        _groups.firstWhere((group) => group.id == -peerId, orElse: () => null);

    if (group != null) {
      _cache[peerId] = ProfileCacheItem(
        avatar: group.photo50,
        name: group.name,
        isOnline: false,
      );
      return _cache[peerId];
    }

    return unknown;
  }

  void setOnline(int profileId, bool isOnline) {
    final profile = _profiles.firstWhere((profile) => profile.id == profileId,
        orElse: () => null);

    if (profile != null) {
      _cache[profileId] = _cache[profileId].copyWith(isOnline: isOnline);
    }
  }
}

const ProfileCacheItem unknown = ProfileCacheItem(
  avatar: null,
  name: 'Неизвестно',
  isOnline: false,
);
