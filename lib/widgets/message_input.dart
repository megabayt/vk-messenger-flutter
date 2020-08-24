import 'dart:math';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/store/send_store.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController textEditingController = TextEditingController();

  void _pickEmojiHandler(Emoji emoji, Category _) {
    textEditingController.text += emoji.emoji;
  }

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
    final chatStore = Provider.of<ChatStore>(context);
    final showEmojiKeyboard = chatStore.showEmojiKeyboard;

    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final hintColor = Theme.of(context).textTheme.caption.color;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(Icons.insert_emoticon),
                onPressed: chatStore.toggleEmojiKeyboard,
                color: showEmojiKeyboard ? primaryColor : primaryColor.withOpacity(.5),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: () {},
                color: primaryColor.withOpacity(.5),
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
        ),
        if (showEmojiKeyboard)
          EmojiPicker(
            rows: 3,
            columns: 7,
            numRecommended: 10,
            onEmojiSelected: _pickEmojiHandler,
          ),
      ],
    );
  }
}
