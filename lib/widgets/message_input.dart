import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/store/send_store.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  Function _sendHandler(context) => () async {
        final peerId = Provider.of<ChatStore>(context, listen: false).peerId;
        int int32max = 1 << 32;
        await Provider.of<SendStore>(context, listen: false).sendMessage({
          'peer_id': peerId.toString(),
          'random_id': Random.secure().nextInt(int32max).toString(),
          'message': textEditingController.text,
        });
        textEditingController.clear();
      };

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final hintColor = Theme.of(context).textTheme.caption.color;
    return Row(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 1.0),
          child: IconButton(
            icon: Icon(Icons.insert_emoticon),
            onPressed: () {},
            color: primaryColor,
          ),
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 1.0),
          child: IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
            color: primaryColor,
          ),
        ),
        // Edit text
        Flexible(
          child: Container(
            child: TextField(
              style: TextStyle(color: textColor, fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Сообщение',
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
        ),

        // Button send message
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendHandler(context),
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
