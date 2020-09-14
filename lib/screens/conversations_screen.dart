import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/widgets/conversations_list.dart';

class ConversationsScreen extends StatelessWidget {
  static const routeUrl = '/chats';

  void _handleLogoutPressed(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(UserLogOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vk Messenger Flutter'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _handleLogoutPressed(context),
          )
        ]
      ),
      body: ConversationsList(),
    );
  }
}
