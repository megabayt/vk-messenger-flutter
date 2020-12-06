import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/widgets/conversation_app_bar.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';

class ConversationScreen extends StatelessWidget {
  static const routeUrl = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConversationAppBar(),
      body: MessagesList(),
    );
  }
}
