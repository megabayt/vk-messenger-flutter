import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:map_path/map_path.dart';

class Message {
  Message({
    this.id,
    this.fromId,
    this.date,
    this.text,
    this.fwdMessages,
    this.attachments,
    this.latitude,
    this.longitude,
    this.place,
    this.isOut,
    this.isImportant,
    this.isSent = true,
    this.isError = false,
  });

  final int id;
  final int fromId;
  final int date;
  final String text;
  final List<Message> fwdMessages;
  final List<Attachment> attachments;
  final double latitude;
  final double longitude;
  final String place;
  final bool isOut;
  final bool isImportant;
  final bool isSent;
  final bool isError;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id'] == null ? null : json['id'],
        fromId: json['from_id'] == null ? null : json['from_id'],
        date: json['date'] == null ? null : json['date'],
        text: json['text'] == null ? null : json['text'],
        fwdMessages: json["fwd_messages"] == null
            ? null
            : List<Message>.from(
                json["fwd_messages"].map((x) => Message.fromJson(x))),
        attachments: json["attachments"] == null
            ? null
            : List<Attachment>.from(
                json["attachments"].map((x) => Attachment.fromJson(x))),
        latitude: mapPath(json, ['geo', 'coordinates', 'latitude']) == null
            ? null
            : mapPath(json, ['geo', 'coordinates', 'latitude']),
        longitude: mapPath(json, ['geo', 'coordinates', 'longitude']) == null
            ? null
            : mapPath(json, ['geo', 'coordinates', 'longitude']),
        place: mapPath(json, ['geo', 'place', 'title']) == null
            ? null
            : mapPath(json, ['geo', 'place', 'title']),
        isOut: json['out'] == 1,
        isImportant: json['important'] == 1,
      );

  Message copyWith({
    final int id,
    final int fromId,
    final int date,
    final String text,
    final List<Message> fwdMessages,
    final List<Attachment> attachments,
    final double latitude,
    final double longitude,
    final String place,
    final bool isOut,
    final bool isImportant,
    final bool isSent,
    final bool isError,
  }) =>
      Message(
        id: id ?? this.id,
        fromId: fromId ?? this.fromId,
        date: date ?? this.date,
        text: text ?? this.text,
        fwdMessages: fwdMessages ?? this.fwdMessages,
        attachments: attachments ?? this.attachments,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        place: place ?? this.place,
        isOut: isOut ?? this.isOut,
        isImportant: isImportant ?? this.isImportant,
        isSent: isSent ?? this.isSent,
        isError: isError ?? this.isError,
      );
}
