import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';

class AttachmentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  AttachmentsAppBar({
    this.bottom,
    this.toolbarHeight,
  });

  final PreferredSizeWidget bottom;
  final double toolbarHeight;
  final picker = ImagePicker();

  get preferredSize {
    return Size.fromHeight(toolbarHeight ??
        kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
  }

  void _popupMenuHandler(
      BuildContext context, AttachmentsAppBarMenuAction action) {
    switch (action) {
      case AttachmentsAppBarMenuAction.PHOTO_GALLERY:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachImageFromGallery());
        break;
      case AttachmentsAppBarMenuAction.PHOTO_CAMERA:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachImageFromCamera());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AttachmentsBloc, AttachmentsState>(
      listener: (_, state) {
        if (state.error != '') {
          final snackBar = SnackBar(
            content: Text(state.error),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      child: AppBar(
        title: Text('Вложения'),
        actions: [
          PopupMenuButton<AttachmentsAppBarMenuAction>(
            icon: Icon(Icons.add),
            onSelected: (action) => _popupMenuHandler(context, action),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Фото (из галереи)'),
                  value: AttachmentsAppBarMenuAction.PHOTO_GALLERY,
                ),
                PopupMenuItem(
                  child: Text('Фото (с камеры)'),
                  value: AttachmentsAppBarMenuAction.PHOTO_CAMERA,
                ),
                PopupMenuItem(
                  child: Text('Фото (из моих альбомов)'),
                  value: AttachmentsAppBarMenuAction.PHOTO_ALBUM,
                ),
                PopupMenuItem(
                  child: Text('Аудио'),
                  value: AttachmentsAppBarMenuAction.AUDIO,
                ),
                PopupMenuItem(
                  child: Text('Видео (из галереи)'),
                  value: AttachmentsAppBarMenuAction.VIDEO_GALLERY,
                ),
                PopupMenuItem(
                  child: Text('Видео (с камеры)'),
                  value: AttachmentsAppBarMenuAction.VIDEO_CAMERA,
                ),
                PopupMenuItem(
                  child: Text('Видео (из моих альбомов)'),
                  value: AttachmentsAppBarMenuAction.VIDEO_ALBUM,
                ),
                PopupMenuItem(
                  child: Text('Документ'),
                  value: AttachmentsAppBarMenuAction.DOCUMENT,
                ),
                PopupMenuItem(
                  child: Text('Местоположение'),
                  value: AttachmentsAppBarMenuAction.GEO,
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

enum AttachmentsAppBarMenuAction {
  PHOTO_GALLERY,
  PHOTO_CAMERA,
  PHOTO_ALBUM,
  AUDIO,
  VIDEO_GALLERY,
  VIDEO_CAMERA,
  VIDEO_ALBUM,
  DOCUMENT,
  GEO,
}
