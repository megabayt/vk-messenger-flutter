import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/widgets/attachment.dart';

class Message extends StatelessWidget {
  _fwdMsgTapHandler(FwdMessage fwdMessage) {}

  @override
  Widget build(BuildContext context) {
    final chatStore = Provider.of<ChatStore>(context);
    final item = Provider.of<Item>(context);
    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen

    final me = item?.fromId == chatStore?.currentUserId;

    final text = item?.text ?? '';

    final attachments = item?.attachments ?? [];

    final fwdMessages = item?.fwdMessages ?? [];

    var rows = <Widget>[];

    final textAlign = me ? TextAlign.right : TextAlign.left;

    if (text != '') {
      rows.add(Text(text, textAlign: textAlign));
    }

    if (attachments.length != 0) {
      rows.addAll(
        attachments.map(
          (attachment) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Attachment(attachment, me),
          ),
        ),
      );
    }

    if (fwdMessages.length != 0) {
      rows.addAll(
        fwdMessages.map(
          (message) => GestureDetector(
            onTap: () => _fwdMsgTapHandler(message),
            child: Text('Пересланные сообщения',
                textAlign: textAlign,
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, .5))),
          ),
        ),
      );
    }

    return Bubble(
      margin: BubbleEdges.symmetric(vertical: 7),
      alignment: me ? Alignment.topRight : Alignment.topLeft,
      nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: me ? Color.fromRGBO(225, 255, 199, 1.0) : null,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: width,
        ),
        child: Column(
          children: rows,
          crossAxisAlignment: CrossAxisAlignment.end,
        ),
      ),
    );
  }
}
