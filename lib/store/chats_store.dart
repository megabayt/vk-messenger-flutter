import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

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

class ChatsStore with ChangeNotifier {
  static const PAGE_COUNT = '20';
  VKService _vkService = locator<VKService>();
  bool _isFetching = false;
  VkConversations _data;
  VkConversations get data {
    return _data;
  }

  final _profilesCache = Map<int, ProfileCacheItem>();

  Future<VkConversations> _getData(Map<String, String> params) async {
    _isFetching = true;

    final getConversationsUrl =
        '${BASE_URL}messages.getConversations?access_token=${_vkService.token}&v=$VERSION&extended=1${serialize(params)}';

    final response = await http.get(getConversationsUrl);

    _isFetching = false;

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }

    return VkConversations.fromJson(responseBody);
  }

  Future<void> getInitialData() async {
    if (_isFetching) {
      return;
    }

    _data = await _getData({
      'count': PAGE_COUNT,
      'offset': '0',
    });

    notifyListeners();
  }

  Future<void> getNextData() async {
    if (_isFetching) {
      return;
    }

    if (_data == null) {
      await getInitialData();
      notifyListeners();
      return;
    }

    final newData = await _getData({
      'count': PAGE_COUNT,
      'offset': _data.response.items.length.toString(),
    });

    _data.response.items.addAll(newData.response.items);
    _data.response.profiles.addAll(newData.response.profiles);
    _data.response.groups.addAll(newData.response.groups);

    notifyListeners();
  }

  ProfileCacheItem getProfile(int peerId) {
    if (peerId == null) {
      return ProfileCacheItem(
        null,
        'Неизвестно',
      );
    }

    if (_profilesCache.containsKey(peerId)) {
      return _profilesCache[peerId];
    }
    final profiles = _data?.response?.profiles ?? [];

    final profile = profiles.firstWhere((profile) => profile.id == peerId,
        orElse: () => null);

    if (profile != null) {
      _profilesCache[peerId] = ProfileCacheItem(
        profile.photo50,
        '${profile?.firstName} ${profile?.lastName}',
      );
      return _profilesCache[peerId];
    }

    final groups = _data?.response?.groups ?? [];

    final group =
        groups.firstWhere((group) => group.id == -peerId, orElse: () => null);

    if (group != null) {
      _profilesCache[peerId] = ProfileCacheItem(
        group.photo50,
        group.name,
      );
      return _profilesCache[peerId];
    }

    return ProfileCacheItem(
      null,
      'Неизвестно',
    );
  }
}
