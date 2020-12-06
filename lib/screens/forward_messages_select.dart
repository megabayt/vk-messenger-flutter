import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/widgets/conversations_list.dart';
import 'package:vk_messenger_flutter/widgets/friends_list.dart';

class ForwardMessagesSelect extends StatelessWidget {
  static const routeUrl = '/forward_messages_select';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Друзья'),
              Tab(text: 'Диалоги'),
            ],
          ),
          title: Text('Выбор собеседника'),
        ),
        body: TabBarView(
          children: [
            FriendsList(),
            ConversationsList(fwdSelectMode: true),
          ],
        ),
      ),
    );
  }
}
