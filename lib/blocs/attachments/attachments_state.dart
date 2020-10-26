part of 'attachments_bloc.dart';

@immutable
class AttachmentsState {
  final bool isFetching;
  final String error;
  final List<LocalAttachment> attachments;
  final List<int> fwdMessages;
  final LatLng location;

  AttachmentsState({
    this.isFetching = false,
    this.error = '',
    this.fwdMessages = const [],
    this.attachments = const [],
    this.location = const LatLng(0, 0),
  });

  AttachmentsState copyWith({
    bool isFetching,
    String error,
    List<int> fwdMessages,
    List<LocalAttachment> attachments,
    LatLng location,
  }) =>
      AttachmentsState(
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        fwdMessages: fwdMessages ?? this.fwdMessages,
        attachments: attachments ?? this.attachments,
        location: location ?? this.location,
      );
}
