import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';

class AttachmentVideo extends StatelessWidget {
  Function _tapHandler(BuildContext context) => () async {
        final attachment = Provider.of<Attachment>(context, listen: false);

        final url =
            'https://vk.com/video${attachment?.video?.ownerId}_${attachment?.video?.id}';

        if (url != '' && await canLaunch(url)) {
          await launch(url);
        }
      };

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final images = attachment?.video?.image ?? [];
    if (images.length == 0) {
      return Container();
    }
    return GestureDetector(
      onTap: _tapHandler(context),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(image: NetworkImage(images[0].url)),
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
            attachment?.video?.title ?? '',
            textAlign: me ? TextAlign.right : TextAlign.left,
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, .5)),
          ),
        ],
      ),
    );
  }
}
