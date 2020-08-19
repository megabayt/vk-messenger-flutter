import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/screens/photos_page.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';

class AttachmentPhoto extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final messages = Provider.of<ChatStore>(context, listen: false)
                ?.data
                ?.response
                ?.items ??
            [];
        final message = Provider.of<Message>(context, listen: false);
        final messageIndex =
            messages.indexWhere((element) => element?.id == message?.id);

        final attachments = message?.attachments ?? [];
        final attachmentIndex =
            attachments.indexWhere((element) => element == attachment);

        Navigator.of(context).pushNamed(PhotosPage.routeUrl, arguments: {
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
