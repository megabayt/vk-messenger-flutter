// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AttachmentsStateCopyWith on AttachmentsState {
  AttachmentsState copyWith({
    List<Attachment> attachments,
    String error,
    List<int> fwdMessages,
    bool isFetching,
    LatLng location,
  }) {
    return AttachmentsState(
      attachments: attachments ?? this.attachments,
      error: error ?? this.error,
      fwdMessages: fwdMessages ?? this.fwdMessages,
      isFetching: isFetching ?? this.isFetching,
      location: location ?? this.location,
    );
  }
}
