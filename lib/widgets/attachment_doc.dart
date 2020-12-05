import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';

class AttachmentDoc extends StatelessWidget {
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

    final preview = attachment?.preview;

    final captionTheme = Theme.of(context).textTheme.caption;

    return GestureDetector(
      onTap: () => _tapHandler(context),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (preview != null) Image(image: NetworkImage(preview)),
          if (preview != null)
            Padding(
              padding: EdgeInsets.all(10),
            ),
          Text(
            attachment?.title ?? '',
            textAlign: me ? TextAlign.right : TextAlign.left,
            style: captionTheme,
          ),
        ],
      ),
    );
  }
}
