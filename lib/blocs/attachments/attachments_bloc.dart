import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/local_attachment.dart';
import 'package:vk_messenger_flutter/models/vk_photo_upload_result.dart';
import 'package:vk_messenger_flutter/services/interfaces/upload_service.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'attachments_event.dart';
part 'attachments_state.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  final _picker = ImagePicker();
  final VKService _vkService = locator<VKService>();
  final UploadService _uploadService = locator<UploadService>();

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
    if (event is AttachmentsClearAttachments) {
      yield* _mapAttachmentsClearAttachmentsToState();
    }
    if (event is AttachmentsAttachImage) {
      yield* _mapAttachmentsAttachImageToState(event);
    }
    if (event is AttachmentsRemoveAttachment) {
      yield* mapAttachmentsRemoveAttachmentToState(event);
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

  Stream<AttachmentsState> _mapAttachmentsClearAttachmentsToState() async* {
    yield state.copyWith(
      fwdMessages: [],
      attachments: [],
    );
  }

  Stream<AttachmentsState> _mapAttachmentsAttachImageToState(
      AttachmentsAttachImage event) async* {
    try {
      final pickedFile = await _picker.getImage(source: event.imageSource);

      if (pickedFile == null) {
        return;
      }

      final attachment = LocalAttachment(
        path: pickedFile?.path,
        isFetching: true,
      );

      yield state.copyWith(
        attachments: [
          ...state.attachments,
          attachment,
        ],
      );

      final uploadServer = await _vkService.getPhotoMessagesUploadServer({
        'peer_id': event.peerId.toString(),
      });

      if (uploadServer?.error != null) {
        throw Exception();
      }

      final uploadResult = VkPhotoUploadResult.fromJson(
        await _uploadService.upload(
          File(pickedFile.path),
          uploadServer.response.uploadUrl,
        ),
      );

      final saveResult = await _vkService.saveMessagesPhoto({
        'photo': uploadResult?.photo,
        'server': uploadResult?.server.toString(),
        'hash': uploadResult?.hash,
      });

      if (saveResult?.error != null) {
        throw Exception();
      }

      final ownerId = saveResult.response.ownerId;
      final photoId = saveResult.response.id;

      final attachments = List<LocalAttachment>.from(state?.attachments ?? []);

      yield state.copyWith(
        attachments: attachments.map((element) {
          if (element == attachment) {
            return LocalAttachment(
                isFetching: false, path: 'photo${ownerId}_$photoId');
          }
          return element;
        }).toList(),
      );
    } catch (error) {
      var errorText = 'Произошла ошибка';
      if (error is PlatformException && error?.code == 'photo_access_denied') {
        errorText = 'Нет доступа к галерее изображений';
      }
      yield state.copyWith(error: errorText);
    }
  }

  Stream<AttachmentsState> mapAttachmentsRemoveAttachmentToState(
      AttachmentsRemoveAttachment event) async* {
    yield state.copyWith(
      attachments: state.attachments
          .where((element) => element != event.attachment)
          .toList(),
    );
  }
}
