// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AttachmentCopyWith on Attachment {
  Attachment copyWith({
    bool isFetching,
    String path,
    String preview,
    String title,
    VkAttachmentType type,
    bool unavaliable,
    String url,
  }) {
    return Attachment(
      isFetching: isFetching ?? this.isFetching,
      path: path ?? this.path,
      preview: preview ?? this.preview,
      title: title ?? this.title,
      type: type ?? this.type,
      unavaliable: unavaliable ?? this.unavaliable,
      url: url ?? this.url,
    );
  }
}
