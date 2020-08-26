import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class StickersStore with ChangeNotifier {
  VKService _vkService = locator<VKService>();
  bool _isFetching = false;
  List<String> stickers = [];

  Future<void> fetchStickers() async {
    _isFetching = true;

    var params = {
      'code': 'return API.store.getStickersKeywords({\'aliases\':1,\'all_products\':1})',
    };

    final sendMessageUrl =
        '${BASE_URL}execute?access_token=${_vkService.token}&v=$VERSION'
        +'${serialize(params)}';

    final response = await http.get(sendMessageUrl);

    _isFetching = false;

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    stickers = responseBody['response'];
  }
}
