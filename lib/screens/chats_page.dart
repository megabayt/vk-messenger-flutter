import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/widgets/conversations_list.dart';

class ChatsPage extends StatelessWidget {
  static final routeUrl = '/chats';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatsStore>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Vk Messenger Flutter'),
        ),
        body: FutureBuilder(
          future: provider.getInitialData(),
          builder: (BuildContext _, AsyncSnapshot snapShot) {
            return ConversationList();
          },
        ));
  }
}
