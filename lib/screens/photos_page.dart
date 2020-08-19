import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/models/attachment.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';

class PhotosPage extends StatelessWidget {
  static const routeUrl = '/photos';

  final _profilesService = locator<ProfilesService>();
  final int messageIndex;
  final int attachmentIndex;

  PhotosPage(this.messageIndex, this.attachmentIndex);

  @override
  Widget build(BuildContext context) {
    final messages =
        Provider.of<ChatStore>(context, listen: false)?.data?.response?.items ??
            [];

    if (messages.length == 0 || messageIndex == -1) {
      return Center(
        child: Text('Error'),
      );
    }

    final message = messages[messageIndex];
    final attachments = message?.attachments ?? [];
    final imageAttachments = attachments
        .where((element) => element.type == AttachmentType.PHOTO)
        .toList();
    final initialPage = imageAttachments.indexWhere(
              (element) => element == attachments[attachmentIndex]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Фото от ' + _profilesService.getProfile(message?.peerId).name),
      ),
      body: PhotoViewGallery.builder(
        pageController: PageController(initialPage: initialPage),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          final sizes = imageAttachments[index]?.photo?.sizes ?? [];
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(sizes[sizes.length - 1].url),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes:
                PhotoViewHeroAttributes(tag: imageAttachments[index].photo.id),
          );
        },
        itemCount: imageAttachments.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded / event.expectedTotalBytes,
            ),
          ),
        ),
      ),
    );
  }
}
