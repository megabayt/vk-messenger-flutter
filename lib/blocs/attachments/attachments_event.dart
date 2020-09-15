part of 'attachments_bloc.dart';

@immutable
abstract class AttachmentsEvent {}

class AttachmentsForwardMessage extends AttachmentsEvent {
  final List<int> fwdMessages;

  AttachmentsForwardMessage(this.fwdMessages);
}

class AttachmentsRemoveFwdMessages extends AttachmentsEvent {}

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

class AttachmentsAttachDocument extends AttachmentsEvent {}

class AttachmentsRemoveAttachment extends AttachmentsEvent {
  final LocalAttachment attachment;

  AttachmentsRemoveAttachment(this.attachment);
}
