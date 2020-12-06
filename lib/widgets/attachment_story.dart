import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/attachment_story.dart' as AttachmentStoryModel;
import 'package:vk_messenger_flutter/local_models/message.dart';

class AttachmentStory extends StatelessWidget {
  Future<void> _tapHandler(BuildContext context) async {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final url = attachment?.url;

    if (url != '' && await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.isOut == true;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final isExpired = (attachment as AttachmentStoryModel.AttachmentStory)?.isExpired;

    final captionTheme = Theme.of(context).textTheme.caption;

    if (isExpired) {
      return Text(
        'История (недоступна)',
        textAlign: me ? TextAlign.right : TextAlign.left,
        style: captionTheme,
      );
    }

    final preview = attachment?.preview;

    if (preview != null) {
      return GestureDetector(
          onTap: () => _tapHandler(context),
          child: Image(image: NetworkImage(preview)));
    }

    return Container();
  }
}
