import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

class AttachmentsList extends StatelessWidget {
  void _handleDeleteFwdMessages(BuildContext context) {
    BlocProvider.of<ConversationBloc>(context)
        .add(ConversationRemoveFwdMessages());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final fwdMessages = state.fwdMessages ?? [];

        return ListView(
          children: <Widget>[
            if (fwdMessages.length != 0)
              ListTile(
                title: Text('Пересланные сообщения (${fwdMessages.length})'),
                trailing: IconButton(
                  onPressed: () => _handleDeleteFwdMessages(context),
                  icon: Icon(Icons.delete),
                ),
              ),
          ],
        );
      },
    );
  }
}
