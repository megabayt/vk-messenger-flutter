import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';

class AttachmentDoc extends StatelessWidget {
  Future<void> _tapHandler(BuildContext context) async {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final url =
        'https://vk.com/doc${attachment?.doc?.ownerId}_${attachment?.doc?.id}';

    if (url != '' && await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final sizes = attachment?.doc?.preview?.photo?.sizes ?? [];

    final captionTheme = Theme.of(context).textTheme.caption;

    return GestureDetector(
      onTap: () => _tapHandler(context),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (sizes.length != 0) Image(image: NetworkImage(sizes[0].src)),
          if (sizes.length != 0)
            Padding(
              padding: EdgeInsets.all(10),
            ),
          Text(
            attachment?.doc?.title ?? '',
            textAlign: me ? TextAlign.right : TextAlign.left,
            style: captionTheme,
          ),
        ],
      ),
    );
  }
}
