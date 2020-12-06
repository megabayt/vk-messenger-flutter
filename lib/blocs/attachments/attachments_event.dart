part of 'attachments_bloc.dart';

@immutable
abstract class AttachmentsEvent {}

class AttachmentsForwardMessage extends AttachmentsEvent {
  final List<int> fwdMessages;

  AttachmentsForwardMessage(this.fwdMessages);
}

class AttachmentsRemoveFwdMessages extends AttachmentsEvent {}

class AttachmentsRemoveLocation extends AttachmentsEvent {}

class AttachmentsClearAttachments extends AttachmentsEvent {}

class AttachmentsAttachImage extends AttachmentsEvent {
  final int peerId;
  final ImageSource imageSource;

  AttachmentsAttachImage(this.peerId, this.imageSource);
}

class AttachmentsAttachVideo extends AttachmentsEvent {
  final ImageSource imageSource;

  AttachmentsAttachVideo(this.imageSource);
}

class AttachmentsAttachAudio extends AttachmentsEvent {}

class AttachmentsAttachDocument extends AttachmentsEvent {
  final int peerId;

  AttachmentsAttachDocument(this.peerId);
}

class AttachmentsRemoveAttachment extends AttachmentsEvent {
  final Attachment attachment;

  AttachmentsRemoveAttachment(this.attachment);
}

class AttachmentsAttachLocation extends AttachmentsEvent {
  final LatLng location;

  AttachmentsAttachLocation(this.location);
}
