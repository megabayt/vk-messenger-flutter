// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension MessageCopyWith on Message {
  Message copyWith({
    List<Attachment> attachments,
    int date,
    int fromId,
    List<Message> fwdMessages,
    int id,
    bool isError,
    bool isImportant,
    bool isOut,
    bool isSent,
    double latitude,
    double longitude,
    String place,
    String text,
  }) {
    return Message(
      attachments: attachments ?? this.attachments,
      date: date ?? this.date,
      fromId: fromId ?? this.fromId,
      fwdMessages: fwdMessages ?? this.fwdMessages,
      id: id ?? this.id,
      isError: isError ?? this.isError,
      isImportant: isImportant ?? this.isImportant,
      isOut: isOut ?? this.isOut,
      isSent: isSent ?? this.isSent,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      place: place ?? this.place,
      text: text ?? this.text,
    );
  }
}
