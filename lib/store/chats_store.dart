import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class ChatsStore with ChangeNotifier {
  static const PAGE_COUNT = '20';
  VKService _vkService = locator<VKService>();
  ProfilesService _profilesService = locator<ProfilesService>();
  bool _isFetching = false;
  VkConversationsResponseBody _data;
  VkConversationsResponseBody get data {
    return _data;
  }

  Future<VkConversationsResponseBody> _getData(Map<String, String> params) async {
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

    final conversations = VkConversationsResponseBody.fromJson(responseBody);

    _profilesService.appendProfiles(conversations?.response?.profiles);
    _profilesService.appendGroups(conversations?.response?.groups);

    return conversations;
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
    if (newData.response.profiles != null) {
      _data.response.profiles.addAll(newData.response.profiles);
    }
    if (newData.response.groups != null) {
      _data.response.groups.addAll(newData.response.groups);
    }

    notifyListeners();
  }
}
