import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/widgets/conversations_list.dart';

class ConversationsScreen extends StatelessWidget {
  static const routeUrl = '/chats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vk Messenger Flutter'),
      ),
      body: ConversationsList(),
    );
  }
}
