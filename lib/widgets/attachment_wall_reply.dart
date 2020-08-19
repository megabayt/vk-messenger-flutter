import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class AttachmentWallReply extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final url =
            'https://vk.com/wall${attachment?.wallReply?.ownerId}_${attachment?.wallReply?.postId}?reply=${attachment?.wallReply?.id}';

        if (url != '' && await canLaunch(url)) {
          await launch(url);
        }
      };

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final text = getAttachmentReplacer(attachment);
    return GestureDetector(
      onTap: _tapHandler(context),
      child: Text(
        text,
        textAlign: me ? TextAlign.right : TextAlign.left,
        style: TextStyle(color: Color.fromRGBO(0, 0, 0, .5)),
      ),
    );
  }
}
