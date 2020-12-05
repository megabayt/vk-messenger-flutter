import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/screens/photos_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';

class AttachmentPhoto extends StatelessWidget {
  Future<void> _tapHandler(BuildContext context) async {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final message = Provider.of<Message>(context, listen: false);

    final attachments = message?.attachments ?? [];
    final attachmentIndex =
        attachments.indexWhere((element) => element == attachment);

    AppRouter.sailor.navigate(PhotosScreen.routeUrl, params: {
      'fromId': message?.fromId,
      "attachmentIndex": attachmentIndex,
      'attachments': attachments,
    });
  }

  @override
  Widget build(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final preview = attachment?.preview;

    if (preview == null) {
      return Container();
    }

    return GestureDetector(
      onTap: () => _tapHandler(context),
      child: Image(
        image: NetworkImage(preview),
      ),
    );
  }
}
