import 'dart:convert';

import 'package:vk_messenger_flutter/models/attachment.dart';

class Message {
  Message({
    this.id,
    this.fromId,
    this.date,
    this.out,
    this.peerId,
    this.text,
    this.fwdMessages,
    this.important,
    this.attachments,
    this.isSent = true,
    this.isError = false,
  });

  final int date;
  final int fromId;
  final int id;
  final int out;
  final int peerId;
  final String text;
  final List<Message> fwdMessages;
  final bool important;
  final List<Attachment> attachments;
  final bool isSent;
  final bool isError;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Message copyWith({
    final int date,
    final int fromId,
    final int id,
    final int out,
    final int peerId,
    final String text,
    final List<Message> fwdMessages,
    final bool important,
    final List<Attachment> attachments,
    final bool isSent,
    final bool isError,
  }) =>
      Message(
        date: date ?? this.date,
        fromId: fromId ?? this.fromId,
        id: id ?? this.id,
        out: out ?? this.out,
        peerId: peerId ?? this.peerId,
        text: text ?? this.text,
        fwdMessages: fwdMessages ?? this.fwdMessages,
        important: important ?? this.important,
        attachments: attachments ?? this.attachments,
        isSent: isSent ?? this.isSent,
        isError: isError ?? this.isError,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        id: json["id"] == null ? null : json["id"],
        out: json["out"] == null ? null : json["out"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        fwdMessages: json["fwd_messages"] == null
            ? null
            : List<Message>.from(
                json["fwd_messages"].map((x) => Message.fromJson(x))),
        important: json["important"] == null ? null : json["important"],
        attachments: json["attachments"] == null
            ? null
            : List<Attachment>.from(
                json["attachments"].map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "from_id": fromId == null ? null : fromId,
        "id": id == null ? null : id,
        "out": out == null ? null : out,
        "peer_id": peerId == null ? null : peerId,
        "text": text == null ? null : text,
        "fwd_messages": fwdMessages == null
            ? null
            : List<dynamic>.from(fwdMessages.map((x) => x.toJson())),
        "important": important == null ? null : important,
        "attachments": attachments == null
            ? null
            : List<dynamic>.from(attachments.map((x) => x.toJson())),
      };
}
