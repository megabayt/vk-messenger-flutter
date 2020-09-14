import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class AttachmentsList extends StatelessWidget {
  void _handleDeleteFwdMessages(BuildContext context) {
    BlocProvider.of<AttachmentsBloc>(context)
        .add(AttachmentsRemoveFwdMessages());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttachmentsBloc, AttachmentsState>(
      builder: (_, state) {
        final fwdMessages = state.fwdMessages ?? [];
        final attachments = state.attachments ?? [];

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
            ...attachments.map((element) {
              return ListTile(
                title: Text(getAttachmentReplacer(element)),
                trailing: IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.delete),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
