import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';

class AttachmentPoll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.isOut == true;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final title = attachment?.title ?? '';

    final captionTheme = Theme.of(context).textTheme.caption;

    return Text(
      title,
      textAlign: me ? TextAlign.right : TextAlign.left,
      style: captionTheme,
    );
  }
}
