import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/attachment_type.dart';
import 'package:vk_messenger_flutter/vk_models/audio_upload_result.dart';
import 'package:vk_messenger_flutter/vk_models/doc_upload_result.dart';
import 'package:vk_messenger_flutter/vk_models/get_doc_messages_upload_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/get_photo_upload_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/photo_upload_result.dart';
import 'package:vk_messenger_flutter/vk_models/save_audio_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_doc_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_messages_photo_params.dart';
import 'package:vk_messenger_flutter/vk_models/save_video_params.dart';
import 'package:vk_messenger_flutter/vk_models/vk_video_upload_result.dart';
import 'package:vk_messenger_flutter/services/interfaces/upload_service.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'attachments_bloc.g.dart';
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
    if (event is AttachmentsRemoveLocation) {
      yield* _mapAttachmentsRemoveLocationToState();
    }
    if (event is AttachmentsClearAttachments) {
      yield* _mapAttachmentsClearAttachmentsToState();
    }
    if (event is AttachmentsAttachImage) {
      yield* _mapAttachmentsAttachImageToState(event);
    }
    if (event is AttachmentsAttachVideo) {
      yield* _mapAttachmentsAttachVideoToState(event);
    }
    if (event is AttachmentsRemoveAttachment) {
      yield* _mapAttachmentsRemoveAttachmentToState(event);
    }
    if (event is AttachmentsAttachAudio) {
      yield* _mapAttachmentsAttachAudioToState();
    }
    if (event is AttachmentsAttachDocument) {
      yield* _mapAttachmentsAttachDocumentToState(event);
    }
    if (event is AttachmentsAttachLocation) {
      yield* _mapAttachmentsAttachLocationToState(event);
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

  Stream<AttachmentsState> _mapAttachmentsRemoveLocationToState() async* {
    yield state.copyWith(
      location: LatLng(0, 0),
    );
  }

  Stream<AttachmentsState> _mapAttachmentsClearAttachmentsToState() async* {
    yield state.copyWith(
      fwdMessages: [],
      attachments: [],
      location: LatLng(0, 0),
    );
  }

  Stream<AttachmentsState> _mapAttachmentsAttachImageToState(
      AttachmentsAttachImage event) async* {
    Attachment attachment;
    try {
      final pickedFile = await _picker.getImage(source: event.imageSource);

      if (pickedFile == null) {
        return;
      }

      attachment = Attachment(
        url: pickedFile?.path,
        type: VkAttachmentType.PHOTO,
        isFetching: true,
      );

      yield state.copyWith(
        error: '',
        attachments: [
          ...state.attachments,
          attachment,
        ],
      );

      final uploadServer = await _vkService.getPhotoMessagesUploadServer(
        GetPhotoUploadServerParams(
          peerId: event.peerId,
        ),
      );

      if (uploadServer?.error != null) {
        throw Exception('cannot get upload server');
      }

      final uploadResult = VkPhotoUploadResult.fromMap(
        await _uploadService.upload(
          File(pickedFile.path),
          uploadServer.response.uploadUrl,
        ),
      );

      final saveResult = await _vkService.saveMessagesPhoto(
        SaveMessagesPhotoParams(
          photo: uploadResult?.photo,
          server: uploadResult?.server,
          hash: uploadResult?.hash,
        ),
      );

      if (saveResult?.error != null ||
          saveResult?.response == null ||
          saveResult.response?.length == 0) {
        throw Exception('cannot save uploaded photo');
      }

      final ownerId = saveResult.response[0].ownerId;
      final photoId = saveResult.response[0].id;

      final attachments = List<Attachment>.from(state?.attachments ?? []);

      yield state.copyWith(
        attachments: attachments.map((element) {
          if (element == attachment) {
            return attachment.copyWith(
              isFetching: false,
              path: 'photo${ownerId}_$photoId',
            );
          }
          return element;
        }).toList(),
      );
    } catch (error) {
      var errorText = 'Произошла ошибка';
      if (error is PlatformException && error?.code == 'photo_access_denied') {
        errorText = 'Нет доступа к галерее изображений';
      }
      yield state.copyWith(
          error: errorText,
          attachments:
              List<Attachment>.from(state?.attachments ?? []).where((element) {
            return element != attachment;
          }).toList());
    }
  }

  Stream<AttachmentsState> _mapAttachmentsAttachVideoToState(
      AttachmentsAttachVideo event) async* {
    Attachment attachment;
    try {
      final pickedFile = await _picker.getVideo(source: event.imageSource);

      if (pickedFile == null) {
        return;
      }

      attachment = Attachment(
        url: pickedFile?.path,
        type: VkAttachmentType.VIDEO,
        isFetching: true,
      );

      yield state.copyWith(
        error: '',
        attachments: [
          ...state.attachments,
          attachment,
        ],
      );

      final saveResult = await _vkService.saveVideo(SaveVideoParams(
        isPrivate: true,
      ));

      if (saveResult?.error != null) {
        throw Exception('cannot save video');
      }

      final uploadResult = VkVideoUploadResult.fromMap(
        await _uploadService.upload(
          File(pickedFile.path),
          saveResult.response.uploadUrl,
        ),
      );

      final ownerId = saveResult.response.ownerId;
      final videoId = uploadResult.videoId;

      final attachments = List<Attachment>.from(state?.attachments ?? []);

      yield state.copyWith(
        attachments: attachments.map((element) {
          if (element == attachment) {
            return attachment.copyWith(
              isFetching: false,
              path: 'video${ownerId}_$videoId',
            );
          }
          return element;
        }).toList(),
      );
    } catch (error) {
      var errorText = 'Произошла ошибка';
      yield state.copyWith(
          error: errorText,
          attachments:
              List<Attachment>.from(state?.attachments ?? []).where((element) {
            return element != attachment;
          }).toList());
    }
  }

  Stream<AttachmentsState> _mapAttachmentsRemoveAttachmentToState(
      AttachmentsRemoveAttachment event) async* {
    yield state.copyWith(
      attachments: state.attachments
          .where((element) => element != event.attachment)
          .toList(),
    );
  }

  Stream<AttachmentsState> _mapAttachmentsAttachAudioToState() async* {
    Attachment attachment;
    try {
      FilePickerResult pickerResult =
          await FilePicker.platform.pickFiles(type: FileType.audio);

      if (pickerResult == null) {
        return;
      }

      String path = pickerResult.files.single.path;

      attachment = Attachment(
        path: path,
        type: VkAttachmentType.AUDIO,
        isFetching: true,
      );

      yield state.copyWith(
        error: '',
        attachments: [
          ...state.attachments,
          attachment,
        ],
      );

      final uploadServer = await _vkService.getAudioUploadServer();

      if (uploadServer?.error != null) {
        throw Exception('cannot get upload server');
      }

      final uploadResult = VkAudioUploadResult.fromMap(
        await _uploadService.upload(
          File(path),
          uploadServer.response.uploadUrl,
        ),
      );

      final saveResult = await _vkService.saveAudio(SaveAudioParams(
        server: uploadResult?.server,
        hash: uploadResult?.hash,
        audio: uploadResult?.audio,
      ));

      if (saveResult?.error != null) {
        throw Exception('cannot save uploaded audio');
      }

      final ownerId = saveResult.response.ownerId;
      final audioId = saveResult.response.id;

      final attachments = List<Attachment>.from(state?.attachments ?? []);

      yield state.copyWith(
        attachments: attachments.map((element) {
          if (element == attachment) {
            return attachment.copyWith(
                isFetching: false, path: 'audio${ownerId}_$audioId');
          }
          return element;
        }).toList(),
      );
    } catch (error) {
      var errorText = 'Произошла ошибка';
      yield state.copyWith(
          error: errorText,
          attachments:
              List<Attachment>.from(state?.attachments ?? []).where((element) {
            return element != attachment;
          }).toList());
    }
  }

  Stream<AttachmentsState> _mapAttachmentsAttachDocumentToState(
      AttachmentsAttachDocument event) async* {
    Attachment attachment;
    try {
      FilePickerResult pickerResult =
          await FilePicker.platform.pickFiles(type: FileType.any);

      if (pickerResult == null) {
        return;
      }

      String path = pickerResult.files.single.path;
      String fileName = pickerResult.files.single.name;

      attachment = Attachment(
        path: path,
        isFetching: true,
      );

      yield state.copyWith(
        error: '',
        attachments: [
          ...state.attachments,
          attachment,
        ],
      );

      final uploadServer = await _vkService.getDocMessagesUploadServer(
        GetDocMessagesUploadServerParams(
          type: 'doc',
          peerId: event.peerId,
        ),
      );

      if (uploadServer?.error != null) {
        throw Exception('cannot get upload server');
      }

      final uploadResult = VkDocUploadResult.fromMap(
        await _uploadService.upload(
          File(path),
          uploadServer.response.uploadUrl,
        ),
      );

      final saveResult = await _vkService
          .saveDoc(SaveDocParams(file: uploadResult?.file, title: fileName));

      if (saveResult?.error != null) {
        throw Exception('cannot save uploaded audio');
      }

      final ownerId = saveResult.response.doc.ownerId;
      final docId = saveResult.response.doc.id;

      final attachments = List<Attachment>.from(state?.attachments ?? []);

      yield state.copyWith(
        attachments: attachments.map((element) {
          if (element == attachment) {
            return attachment.copyWith(
                isFetching: false, path: 'doc${ownerId}_$docId');
          }
          return element;
        }).toList(),
      );
    } catch (error) {
      var errorText = 'Произошла ошибка';
      yield state.copyWith(
          error: errorText,
          attachments:
              List<Attachment>.from(state?.attachments ?? []).where((element) {
            return element != attachment;
          }).toList());
    }
  }

  Stream<AttachmentsState> _mapAttachmentsAttachLocationToState(
      AttachmentsAttachLocation event) async* {
    yield state.copyWith(location: event.location);
  }
}
