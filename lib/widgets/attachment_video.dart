import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';

class AttachmentVideo extends StatelessWidget {
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

    if (preview == null) {
      return Container();
    }
    return GestureDetector(
      onTap: () => _tapHandler(context),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(image: NetworkImage(preview)),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, .5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/video_play_small_2x.png'),
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
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
