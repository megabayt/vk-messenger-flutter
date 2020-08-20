import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class AttachmentLink extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final url = attachment?.link?.url ?? '';

        if (url != '' && await canLaunch(url)) {
          await launch(url);
        }
      };

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final captionTheme = Theme.of(context).textTheme.caption;

    final text = getAttachmentReplacer(attachment);
    return GestureDetector(
      onTap: _tapHandler(context),
      child: Text(
        text,
        textAlign: me ? TextAlign.right : TextAlign.left,
        style: captionTheme,
      ),
    );
  }
}
