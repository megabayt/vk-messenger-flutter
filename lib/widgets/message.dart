import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatStore = Provider.of<ChatStore>(context);
    final item = Provider.of<Item>(context);

    final me = item?.fromId == chatStore?.currentUserId;

    return Bubble(
      margin: BubbleEdges.symmetric(vertical: 7),
      alignment: me ? Alignment.topRight : Alignment.topLeft,
      nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: me ? Color.fromRGBO(225, 255, 199, 1.0) : null,
      child: Text(item?.text ?? '',
          textAlign: me ? TextAlign.left : TextAlign.right),
    );
  }
}
