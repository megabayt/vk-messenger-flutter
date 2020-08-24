import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class ChatStore with ChangeNotifier {
  static const PAGE_COUNT = '20';
  VKService _vkService = locator<VKService>();
  int get currentUserId {
    return _vkService.userId;
  }
  ProfilesService _profilesService = locator<ProfilesService>();
  int _peerId;
  get peerId {
    return _peerId;
  }
  bool _isFetching = false;
  var _data = Map<int, VkConversationResponseBody>();
  VkConversationResponseBody get data {
    return _data[_peerId];
  }
  bool _showEmojiKeyboard = false;
  get showEmojiKeyboard {
    return _showEmojiKeyboard;
  }

  void toggleEmojiKeyboard() {
    _showEmojiKeyboard = !_showEmojiKeyboard;
    notifyListeners();
  }

  Future<VkConversationResponseBody> _getData(Map<String, String> params) async {
    _isFetching = true;

    final getConversationUrl =
        '${BASE_URL}messages.getHistory?access_token=${_vkService.token}&v=$VERSION&extended=1${serialize(params)}';

    final response = await http.get(getConversationUrl);

    _isFetching = false;

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    if (responseBody == null) {
      return null;
    }
    final conversation = VkConversationResponseBody.fromJson(responseBody);

    _profilesService.appendProfiles(conversation?.response?.profiles);
    _profilesService.appendGroups(conversation?.response?.groups);

    return conversation;
  }

  Future<void> getInitialData(int peerId) async {
    _peerId = peerId;
    if (_isFetching) {
      return;
    }

    _data[peerId] = await _getData({
      'count': PAGE_COUNT,
      'offset': '0',
      'peer_id': peerId.toString()
    });

    notifyListeners();
  }

  Future<void> getNextData() async {
    if (_isFetching) {
      return;
    }

    if (_data == null) {
      await getInitialData(_peerId);
      notifyListeners();
      return;
    }

    final newData = await _getData({
      'count': PAGE_COUNT,
      'offset': _data[_peerId].response.items.length.toString(),
      'peer_id': _peerId.toString()
    });

    _data[_peerId].response.items.addAll(newData.response.items);

    notifyListeners();
  }
}
