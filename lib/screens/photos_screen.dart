import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/attachment_photo.dart';
import 'package:vk_messenger_flutter/local_models/profile.dart';

class PhotosScreen extends StatelessWidget {
  static const routeUrl = '/photos';

  final int fromId;
  final int attachmentIndex;
  final List<Attachment> attachments;

  PhotosScreen(this.fromId, this.attachmentIndex, this.attachments);

  @override
  Widget build(BuildContext context) {
    final imageAttachments =
        attachments.where((element) => element is AttachmentPhoto).toList();
    final initialPage = imageAttachments
        .indexWhere((element) => element == attachments[attachmentIndex]);

    return BlocBuilder<ProfilesBloc, ProfilesState>(
      builder: (context, state) {
        final profile = (state as ProfilesInitial)?.profiles?.getById(fromId);
        final name = profile?.name ?? '';

        return Scaffold(
          appBar: AppBar(
            title: Text('Фото от ' + name),
          ),
          body: PhotoViewGallery.builder(
            pageController: PageController(initialPage: initialPage),
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              final url = imageAttachments[index].url;

              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(url),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: url),
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
      },
    );
  }
}
