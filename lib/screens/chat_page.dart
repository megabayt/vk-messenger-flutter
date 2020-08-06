import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';

class ChatPageScreenArguments {
  final int peerId;

  ChatPageScreenArguments(this.peerId);
}

class ChatPage extends StatelessWidget {
  static final routeUrl = '/chat';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatStore>(context, listen: false);
    final ChatPageScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Vk Messenger Flutter'),
        ),
        body: FutureBuilder(
          future: provider.getInitialData(args?.peerId),
          builder: (BuildContext _, AsyncSnapshot snapShot) {
            return Center(
              child: Text(args?.peerId.toString() ?? 'No peer id'),
            );
          },
        ));
  }
}
