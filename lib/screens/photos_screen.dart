import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';

class PhotosScreen extends StatelessWidget {
  static const routeUrl = '/photos';

  final _profilesService = locator<ProfilesService>();
  final int fromId;
  final int attachmentIndex;
  final List<Attachment> attachments;

  PhotosScreen(this.fromId, this.attachmentIndex, this.attachments);

  @override
  Widget build(BuildContext context) {
    final imageAttachments = attachments
        .where((element) => element.type == AttachmentType.PHOTO)
        .toList();
    final initialPage = imageAttachments
        .indexWhere((element) => element == attachments[attachmentIndex]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Фото от ' + _profilesService.getProfile(fromId).name),
      ),
      body: PhotoViewGallery.builder(
        pageController: PageController(initialPage: initialPage),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          final sizes = imageAttachments[index]?.photo?.sizes ?? [];
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(sizes[sizes.length - 1].url),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            heroAttributes: PhotoViewHeroAttributes(
                tag: imageAttachments[index].photo.id),
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