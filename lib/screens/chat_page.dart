import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/widgets/message_input.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';

class ChatPage extends StatefulWidget {
  static const routeUrl = '/chat';

  final int peerId;

  ChatPage(this.peerId);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _profilesService = locator<ProfilesService>();
  Future<void> _initDataFuture;

  @override
  Widget build(BuildContext context) {
    if (_initDataFuture == null) {
      _initDataFuture = Provider.of<ChatStore>(context, listen: false)
          .getInitialData(widget.peerId);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(_profilesService.getProfile(widget.peerId).name),
        ),
        body: FutureBuilder(
          future: _initDataFuture,
          builder: (BuildContext _, AsyncSnapshot snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final showEmojiKeyboard = Provider.of<ChatStore>(context).showEmojiKeyboard;

            final statusBarHeight = MediaQuery.of(context).padding.top;
            final appBarHeight = AppBar().preferredSize.height;
            final screenHeight = MediaQuery.of(context).size.height;
            final bottomOffset = MediaQuery.of(context).viewInsets.bottom;
            final emojiKeyboardHeight = showEmojiKeyboard ? 215.0 : 0.0;

            final inputHeight = 50.0 + emojiKeyboardHeight;

            final messagesListHeight = screenHeight -
                appBarHeight -
                statusBarHeight -
                bottomOffset -
                inputHeight;


            return Column(
              children: <Widget>[
                Container(
                  height: messagesListHeight,
                  child: MessagesList(),
                ),
                Container(
                  width: double.infinity,
                  height: inputHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, .1),
                        blurRadius: 10,
                        offset: Offset.zero,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: MessageInput(),
                )
              ],
            );
          },
        ));
  }
}
