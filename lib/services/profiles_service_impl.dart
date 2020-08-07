import 'package:vk_messenger_flutter/models/vk_conversations.dart';
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
      return ProfileCacheItem(
        null,
        'Неизвестно',
      );
    }

    if (_cache.containsKey(peerId)) {
      return _cache[peerId];
    }

    final profile = _profiles.firstWhere((profile) => profile.id == peerId,
        orElse: () => null);

    if (profile != null) {
      _cache[peerId] = ProfileCacheItem(
        profile.photo50,
        '${profile?.firstName} ${profile?.lastName}',
      );
      return _cache[peerId];
    }


    final group =
        _groups.firstWhere((group) => group.id == -peerId, orElse: () => null);

    if (group != null) {
      _cache[peerId] = ProfileCacheItem(
        group.photo50,
        group.name,
      );
      return _cache[peerId];
    }

    return ProfileCacheItem(
      null,
      'Неизвестно',
    );
  }
}
