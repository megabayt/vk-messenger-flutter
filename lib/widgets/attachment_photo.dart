import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/screens/photos_screen.dart';
import 'package:vk_messenger_flutter/screens/router.dart';

class AttachmentPhoto extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final messages = (BlocProvider.of<ConversationBloc>(context)?.state
                    as ConversationData)
                ?.currentItems ??
            [];
        final message = Provider.of<Message>(context, listen: false);
        final messageIndex =
            messages.indexWhere((element) => element?.id == message?.id);

        final attachments = message?.attachments ?? [];
        final attachmentIndex =
            attachments.indexWhere((element) => element == attachment);

        Router.sailor.navigate(PhotosScreen.routeUrl, params: {
          "messageIndex": messageIndex,
          "attachmentIndex": attachmentIndex,
        });
      };

  @override
  Widget build(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final sizes = attachment?.photo?.sizes ?? [];

    if (sizes.length == 0) {
      return Container();
    }

    return GestureDetector(
      onTap: _tapHandler(context),
      child: Image(
        image: NetworkImage(sizes[0].url),
      ),
    );
  }
}
