import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/send/send_bloc.dart';

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
        final peerId = (BlocProvider.of<ConversationBloc>(context).state
                as ConversationData)
            .peerId;
        BlocProvider.of<SendBloc>(context).add(
          SendMessage(
            peerId: peerId,
            message: textEditingController.text,
          ),
        );
        textEditingController.clear();
      };

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final showEmojiKeyboard =
            (state as ConversationData)?.showEmojiKeyboard;

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
                    onPressed: () =>
                        conversationBloc.add(ConversationToggleEmojiKeyboard()),
                    color: showEmojiKeyboard
                        ? primaryColor
                        : primaryColor.withOpacity(.5),
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
      },
    );
  }
}
