import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';

class ChatPage extends StatelessWidget {
  static const routeUrl = '/chat';

  final int peerId;

  ChatPage(this.peerId);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatStore>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Vk Messenger Flutter'),
        ),
        body: FutureBuilder(
          future: provider.getInitialData(peerId),
          builder: (BuildContext _, AsyncSnapshot snapShot) {
            return Center(
              child: Text(peerId.toString() ?? 'No peer id'),
            );
          },
        ));
  }
}
