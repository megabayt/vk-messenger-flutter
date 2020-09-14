part of 'attachments_bloc.dart';

@immutable
class AttachmentsState {
  final bool isFetching;
  final String error;
  final List<LocalAttachment> attachments;
  final List<int> fwdMessages;

  AttachmentsState({
    this.isFetching = false,
    this.error = '',
    this.fwdMessages = const [],
    this.attachments = const [],
  });

  AttachmentsState copyWith({
    bool isFetching,
    String error,
    List<int> fwdMessages,
    List<LocalAttachment> attachments,
  }) =>
      AttachmentsState(
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        fwdMessages: fwdMessages ?? this.fwdMessages,
        attachments: attachments ?? this.attachments,
      );
}
