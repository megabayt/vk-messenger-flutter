import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class Attachment extends StatelessWidget {
  final ItemAttachment attachment;
  final TextAlign align;

  Attachment(this.attachment, this.align);

  _attachTapHandler(ItemAttachment attachment) async {
    final attachmentType = attachment?.type;

    switch (attachmentType) {
      case AttachmentType.LINK:
        final url = attachment?.link?.url;
        if (await canLaunch(url)) {
          await launch(url);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Text(getAttachmentReplacer(attachment),
        textAlign: align, style: TextStyle(color: Color.fromRGBO(0, 0, 0, .5)));
    if (attachment.type == AttachmentType.PHOTO) {
      child = Image(image: NetworkImage(attachment.photo.sizes[0].url));
    }
    if (attachment.type == AttachmentType.VIDEO) {
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image(image: NetworkImage(attachment.video.image[0].url)),
          Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
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
      );
    }
    return GestureDetector(
      onTap: () => _attachTapHandler(attachment),
      child: child,
    );
  }
}
