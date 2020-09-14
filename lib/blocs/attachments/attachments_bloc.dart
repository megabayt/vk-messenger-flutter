import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/attachment.dart';

part 'attachments_event.dart';
part 'attachments_state.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  final _picker = ImagePicker();

  AttachmentsBloc() : super(AttachmentsState());

  @override
  Stream<AttachmentsState> mapEventToState(
    AttachmentsEvent event,
  ) async* {
    if (event is AttachmentsForwardMessage) {
      yield* _mapAttachmentsForwardMessageToState(event);
    }
    if (event is AttachmentsRemoveFwdMessages) {
      yield* _mapAttachmentsRemoveFwdMessagesToState();
    }
    if (event is AttachmentsAttachImageFromGallery) {
      yield* _mapAttachmentsAttachImageFromGalleryToState();
    }
    if (event is AttachmentsAttachImageFromCamera) {
      yield* _mapAttachmentsAttachImageFromCameraToState();
    }
  }

  Stream<AttachmentsState> _mapAttachmentsForwardMessageToState(
      AttachmentsForwardMessage event) async* {
    yield state.copyWith(
      fwdMessages: event?.fwdMessages ?? [],
    );
  }

  Stream<AttachmentsState> _mapAttachmentsRemoveFwdMessagesToState() async* {
    yield state.copyWith(
      fwdMessages: [],
    );
  }

  Stream<AttachmentsState>
      _mapAttachmentsAttachImageFromGalleryToState() async* {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        yield state.copyWith(
          attachments: [
            ...state.attachments,
            Attachment(
              type: AttachmentType.PHOTO,
              localPath: pickedFile?.path,
            ),
          ],
        );
      }
    } catch (error) {
      var errorText = 'Произошла ошибка';
      if (error is PlatformException && error?.code == 'photo_access_denied') {
        errorText = 'Нет доступа к галерее изображений';
      }
      yield state.copyWith(error: errorText);
    }
  }

  Stream<AttachmentsState>
      _mapAttachmentsAttachImageFromCameraToState() async* {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        // TODO:
      }
    } catch (error) {
      var errorText = 'Произошла ошибка';
      if (error is PlatformException && error?.code == 'camera_access_denied') {
        errorText = 'Нет доступа к камере';
      }
      yield state.copyWith(error: errorText);
    }
  }
}
