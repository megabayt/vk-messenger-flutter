import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';

class AttachmentStory extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final url =
            'https://vk.com/story${attachment?.story?.ownerId}_${attachment?.story?.id}';

        if (url != '' && await canLaunch(url)) {
          await launch(url);
        }
      };

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final isExpired = attachment?.story?.isExpired ?? false;

    final captionTheme = Theme.of(context).textTheme.caption;

    if (isExpired) {
      return Text(
        'История (недоступна)',
        textAlign: me ? TextAlign.right : TextAlign.left,
        style: captionTheme,
      );
    }

    final sizes = attachment.story?.photo?.sizes ?? [];

    if (sizes.length != 0) {
      return GestureDetector(
          onTap: _tapHandler(context),
          child: Image(image: NetworkImage(sizes[0].url)));
    }

    final previews = attachment?.story?.video?.image ?? [];
    if (previews.length != 0) {
      return GestureDetector(
          onTap: _tapHandler(context),
          child: Image(image: NetworkImage(previews[0].url)));
    }

    return Container();
  }
}
