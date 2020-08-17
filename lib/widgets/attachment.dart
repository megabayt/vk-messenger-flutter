import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vk_messenger_flutter/models/vk_conversation.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';

class Attachment extends StatelessWidget {
  final ItemAttachment attachment;
  final bool me;

  get align {
    return me ? TextAlign.right : TextAlign.left;
  }

  get textStyle {
    return TextStyle(color: Color.fromRGBO(0, 0, 0, .5));
  }

  Attachment(this.attachment, this.me);

  _attachTapHandler(ItemAttachment attachment) async {
    final attachmentType = attachment?.type;

    var url = '';

    switch (attachmentType) {
      case AttachmentType.PHOTO:
        // TODO: Отображать в приложении
        url = 'https://vk.com/photo${attachment?.photo?.ownerId}_${attachment?.photo?.id}';
        break;
      case AttachmentType.VIDEO:
        url = 'https://vk.com/video${attachment?.video?.ownerId}_${attachment?.video?.id}';
        break;
      case AttachmentType.AUDIO:
        // TODO: Воспроизводить в приложении
        url = 'https://vk.com/audio${attachment?.audio?.ownerId}_${attachment?.audio?.id}';
        break;
      case AttachmentType.DOC:
        url = 'https://vk.com/doc${attachment?.doc?.ownerId}_${attachment?.doc?.id}';
        break;
      case AttachmentType.STORY:
        url = 'https://vk.com/story${attachment?.story?.ownerId}_${attachment?.story?.id}';
        break;
      case AttachmentType.WALL:
        url = 'https://vk.com/wall${attachment?.wall?.fromId}_${attachment?.wall?.id}';
        break;
      case AttachmentType.WALL_REPLY:
        url = 'https://vk.com/wall${attachment?.wallReply?.ownerId}_${attachment?.wallReply?.postId}?reply=${attachment?.wallReply?.id}';
        break;
      case AttachmentType.LINK:
      default:
        url = attachment?.link?.url ?? '';
        break;
    }
    if (url != '' && await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _getImageWidget() {
    final sizes = attachment?.photo?.sizes ?? [];
    if (sizes.length == 0) {
      return Container();
    }
    return Image(image: NetworkImage(sizes[0].url));
  }

  Widget _getVideoWidget() {
    final images = attachment?.video?.image ?? [];
    if (images.length == 0) {
      return Container();
    }
    return Column(
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
          textAlign: align,
          style: textStyle,
        ),
      ],
    );
  }

  Widget _getGiftWidget() {
    if (attachment?.gift?.thumb48 == null) {
      return Container();
    }
    return Image(image: NetworkImage(attachment.gift.thumb48));
  }

  Widget _getStickerWidget() {
    final images = attachment?.sticker?.images ?? [];
    if (images.length == 0) {
      return Container();
    }
    return Image(image: NetworkImage(images[0].url));
  }

  Widget _getDocWidget() {
    final sizes = attachment?.doc?.preview?.photo?.sizes ?? [];

    return Column(
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
          textAlign: align,
          style: textStyle,
        ),
      ],
    );
  }

  Widget _getStoryWidget() {
    final sizes = attachment.story?.photo?.sizes ?? [];

    if (sizes.length != 0) {
      return Image(image: NetworkImage(sizes[0].url));
    }

    final previews = attachment?.story?.video?.image ?? [];
    if (previews.length != 0) {
      return Image(image: NetworkImage(previews[0].url));
    }

    return Container();
  }

  Widget _getAttachmentWidget() {
    switch (attachment.type) {
      case AttachmentType.PHOTO:
        return _getImageWidget();
      case AttachmentType.VIDEO:
        return _getVideoWidget();
      case AttachmentType.GIFT:
        return _getGiftWidget();
      case AttachmentType.STICKER:
        return _getStickerWidget();
      case AttachmentType.DOC:
        return _getDocWidget();
      case AttachmentType.STORY:
        return _getStoryWidget();
      case AttachmentType.LINK:
      case AttachmentType.POLL:
      case AttachmentType.WALL:
      case AttachmentType.WALL_REPLY:
      default:
        final text = getAttachmentReplacer(attachment);
        return Text(
          text,
          textAlign: align,
          style: textStyle,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _attachTapHandler(attachment),
      child: _getAttachmentWidget(),
    );
  }
}
