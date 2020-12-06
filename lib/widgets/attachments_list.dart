import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/local_models/attachment.dart';

class AttachmentsList extends StatelessWidget {
  void _handleDeleteFwdMessages(BuildContext context) {
    BlocProvider.of<AttachmentsBloc>(context)
        .add(AttachmentsRemoveFwdMessages());
  }

  void _handleDeleteAttachment(BuildContext context, Attachment attachment) {
    BlocProvider.of<AttachmentsBloc>(context)
        .add(AttachmentsRemoveAttachment(attachment));
  }

  void _handleDeleteLocation(BuildContext context) {
    BlocProvider.of<AttachmentsBloc>(context).add(AttachmentsRemoveLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttachmentsBloc, AttachmentsState>(
      listener: (_, state) {
        if (state.error != '') {
          final snackBar = SnackBar(
            content: Text(state.error),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      builder: (_, state) {
        final fwdMessages = state.fwdMessages ?? [];
        final attachments = state.attachments ?? [];
        final location = state.location;

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
              final title =
                  element.isFetching ? 'Идет загрузка' : (element?.title ?? '');

              final tile = ListTile(
                title: Text(title),
                trailing: IconButton(
                  onPressed: () => _handleDeleteAttachment(context, element),
                  icon: Icon(Icons.delete),
                ),
              );

              return element.isFetching
                  ? SkeletonAnimation(
                      child: tile,
                    )
                  : tile;
            }).toList(),
            if (location.latitude != 0 && location.longitude != 0)
              ListTile(
                title: Text('Местоположение'),
                trailing: IconButton(
                  onPressed: () => _handleDeleteLocation(context),
                  icon: Icon(Icons.delete),
                ),
              ),
          ],
        );
      },
    );
  }
}
