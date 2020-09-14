part of 'attachments_bloc.dart';

@immutable
abstract class AttachmentsEvent {}

class AttachmentsForwardMessage extends AttachmentsEvent {
  final List<int> fwdMessages;

  AttachmentsForwardMessage(this.fwdMessages);
}

class AttachmentsRemoveFwdMessages extends AttachmentsEvent {}

class AttachmentsAttachImageFromGallery extends AttachmentsEvent {}

class AttachmentsAttachImageFromCamera extends AttachmentsEvent {}
