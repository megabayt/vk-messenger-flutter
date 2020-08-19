import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vk_messenger_flutter/screens/photos_page.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/models/attachment.dart' as AttachmentModel;
import 'package:vk_messenger_flutter/models/message.dart';

class Attachment extends StatelessWidget {
  final AttachmentModel.Attachment attachment;
  final bool me;

  get align {
    return me ? TextAlign.right : TextAlign.left;
  }

  get textStyle {
    return TextStyle(color: Color.fromRGBO(0, 0, 0, .5));
  }

  Attachment(this.attachment, this.me);

  _attachTapHandler(BuildContext context) =>
      (AttachmentModel.Attachment attachment) async {
        final messages = Provider.of<ChatStore>(context, listen: false)
                ?.data
                ?.response
                ?.items ??
            [];
        final message = Provider.of<Message>(context, listen: false);
        final messageIndex =
            messages.indexWhere((element) => element?.id == message?.id);

        final attachments = message?.attachments ?? [];
        final attachmentIndex =
            attachments.indexWhere((element) => element == attachment);

        final attachmentType = attachment?.type;

        var url = '';

        switch (attachmentType) {
          case AttachmentModel.AttachmentType.PHOTO:
            Navigator.of(context).pushNamed(PhotosPage.routeUrl, arguments: {
              "messageIndex": messageIndex,
              "attachmentIndex": attachmentIndex,
            });
            return;
          case AttachmentModel.AttachmentType.VIDEO:
            url =
                'https://vk.com/video${attachment?.video?.ownerId}_${attachment?.video?.id}';
            break;
          case AttachmentModel.AttachmentType.AUDIO:
            // TODO: Воспроизводить в приложении
            url =
                'https://vk.com/audio${attachment?.audio?.ownerId}_${attachment?.audio?.id}';
            break;
          case AttachmentModel.AttachmentType.DOC:
            url =
                'https://vk.com/doc${attachment?.doc?.ownerId}_${attachment?.doc?.id}';
            break;
          case AttachmentModel.AttachmentType.STORY:
            if (attachment?.story?.isExpired ?? false) {
              return;
            }
            url =
                'https://vk.com/story${attachment?.story?.ownerId}_${attachment?.story?.id}';
            break;
          case AttachmentModel.AttachmentType.WALL:
            url =
                'https://vk.com/wall${attachment?.wall?.fromId}_${attachment?.wall?.id}';
            break;
          case AttachmentModel.AttachmentType.WALL_REPLY:
            url =
                'https://vk.com/wall${attachment?.wallReply?.ownerId}_${attachment?.wallReply?.postId}?reply=${attachment?.wallReply?.id}';
            break;
          case AttachmentModel.AttachmentType.LINK:
          default:
            url = attachment?.link?.url ?? '';
            break;
        }
        if (url != '' && await canLaunch(url)) {
          await launch(url);
        }
      };

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
    final isExpired = attachment?.story?.isExpired ?? false;

    if (isExpired) {
      return Text(
        'История (недоступна)',
        textAlign: align,
        style: textStyle,
      );
    }

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
      case AttachmentModel.AttachmentType.PHOTO:
        return _getImageWidget();
      case AttachmentModel.AttachmentType.VIDEO:
        return _getVideoWidget();
      case AttachmentModel.AttachmentType.GIFT:
        return _getGiftWidget();
      case AttachmentModel.AttachmentType.STICKER:
        return _getStickerWidget();
      case AttachmentModel.AttachmentType.DOC:
        return _getDocWidget();
      case AttachmentModel.AttachmentType.STORY:
        return _getStoryWidget();
      case AttachmentModel.AttachmentType.LINK:
      case AttachmentModel.AttachmentType.POLL:
      case AttachmentModel.AttachmentType.WALL:
      case AttachmentModel.AttachmentType.WALL_REPLY:
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
      onTap: () => _attachTapHandler(context)(attachment),
      child: _getAttachmentWidget(),
    );
  }
}
