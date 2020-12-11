part of 'attachments_bloc.dart';

@immutable
@CopyWith()
class AttachmentsState {
  final bool isFetching;
  final String error;
  final List<Attachment> attachments;
  final List<int> fwdMessages;
  final LatLng location;
  final int replyTo;

  AttachmentsState({
    this.isFetching = false,
    this.error = '',
    this.fwdMessages = const [],
    this.attachments = const [],
    this.location = const LatLng(0, 0),
    this.replyTo = 0,
  });
}
