import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:vk_messenger_flutter/models/message.dart' as MessageModel;
import 'package:vk_messenger_flutter/widgets/attachment.dart';
import 'package:vk_messenger_flutter/widgets/message_skeleton.dart';

class Message extends StatelessWidget {
  _fwdMsgTapHandler(MessageModel.Message fwdMessage) {}

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<MessageModel.Message>(context, listen: false);

    if (item == null) {
      return MessageSkeleton();
    }

    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen

    final me = item?.out == 1;

    final text = item?.text ?? '';

    final attachments = item?.attachments ?? [];

    final fwdMessages = item?.fwdMessages ?? [];

    var rows = <Widget>[];

    final textAlign = me ? TextAlign.right : TextAlign.left;

    final captionTheme = Theme.of(context).textTheme.caption;

    if (text != '') {
      rows.add(Text(text, textAlign: textAlign));
    }

    if (attachments.length != 0) {
      rows.addAll(
        attachments.map(
          (attachment) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Provider.value(
              value: attachment,
              child: Attachment(),
            ),
          ),
        ),
      );
    }

    if (fwdMessages.length != 0) {
      rows.addAll(
        fwdMessages.map(
          (message) => GestureDetector(
            onTap: () => _fwdMsgTapHandler(message),
            child: Text(
              'Пересланные сообщения',
              textAlign: textAlign,
              style: captionTheme,
            ),
          ),
        ),
      );
    }

    final bubbleBody = Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: Column(
        children: rows,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );

    return Bubble(
      margin: BubbleEdges.symmetric(vertical: 7),
      alignment: me ? Alignment.topRight : Alignment.topLeft,
      nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: me ? Color.fromRGBO(225, 255, 199, 1.0) : null,
      child: item?.isSent == true
          ? bubbleBody
          : SkeletonAnimation(
              child: Opacity(
                opacity: .3,
                child: bubbleBody,
              ),
            ),
    );
  }
}
