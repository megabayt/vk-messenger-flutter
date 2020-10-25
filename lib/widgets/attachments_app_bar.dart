import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

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
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);
    final peerId = conversationBloc.state.peerId;

    switch (action) {
      case AttachmentsAppBarMenuAction.PHOTO_GALLERY:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachImage(peerId, ImageSource.gallery));
        break;
      case AttachmentsAppBarMenuAction.PHOTO_CAMERA:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachImage(peerId, ImageSource.camera));
        break;
      case AttachmentsAppBarMenuAction.VIDEO_GALLERY:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachVideo(ImageSource.gallery));
        break;
      case AttachmentsAppBarMenuAction.VIDEO_CAMERA:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachVideo(ImageSource.camera));
        break;
      case AttachmentsAppBarMenuAction.AUDIO:
        BlocProvider.of<AttachmentsBloc>(context).add(AttachmentsAttachAudio());
        break;
      case AttachmentsAppBarMenuAction.DOCUMENT:
        BlocProvider.of<AttachmentsBloc>(context)
            .add(AttachmentsAttachDocument(peerId));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

enum AttachmentsAppBarMenuAction {
  PHOTO_GALLERY,
  PHOTO_CAMERA,
  AUDIO,
  VIDEO_GALLERY,
  VIDEO_CAMERA,
  DOCUMENT,
  GEO,
}
