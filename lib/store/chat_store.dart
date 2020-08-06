import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class ChatStore with ChangeNotifier {
  static const PAGE_COUNT = '20';
  VKService _vkService = locator<VKService>();
  bool _isFetching = false;
  VkConversation _data;
  VkConversation get data {
    return _data;
  }

  Future<VkConversation> _getData(Map<String, String> params) async {
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

    return VkConversation.fromJson(responseBody);
  }

  Future<void> getInitialData(int peerId) async {
    if (_isFetching) {
      return;
    }

    _data = await _getData({
      'count': PAGE_COUNT,
      'offset': '0',
      'peer_id': peerId.toString()
    });

    notifyListeners();
  }

  Future<void> getNextData(int peerId) async {
    if (_isFetching) {
      return;
    }

    if (_data == null) {
      await getInitialData(peerId);
      notifyListeners();
      return;
    }

    final newData = await _getData({
      'count': PAGE_COUNT,
      'offset': _data.response.items.length.toString(),
      'peer_id': peerId.toString()
    });

    _data.response.items.addAll(newData.response.items);

    notifyListeners();
  }
}
