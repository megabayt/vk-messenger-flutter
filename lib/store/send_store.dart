import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vk_messenger_flutter/constants/api.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class SendStore with ChangeNotifier {
  static const PAGE_COUNT = '20';
  VKService _vkService = locator<VKService>();
  bool _isFetching = false;
  List<String> attachments = [];
  List<String> fwdMessages = [];
  int replyTo;

  Future<int> sendMessage(Map<String, String> params) async {
    _isFetching = true;

    final sendMessageUrl =
        '${BASE_URL}messages.send?access_token=${_vkService.token}&v=$VERSION&extended=1'
        +'${serialize(params)}'
        + (attachments.length != 0 ? 'attachment=${attachments.join(',')}' : '')
        + (fwdMessages.length != 0 ? 'forward_messages=${fwdMessages.join(',')}' : '')
        + (replyTo != null ? 'reply_to=${replyTo.toString()}' : '');

    final response = await http.get(sendMessageUrl);

    _isFetching = false;

    Map<String, dynamic> responseBody =
        response?.body != null ? json.decode(response?.body) : null;

    return responseBody != null ? responseBody['response'] : null;
  }
}
