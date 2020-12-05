import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/message.dart';

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

  factory Message.fromVkMessage(VkMessage vkMessage) => Message(
        id: vkMessage?.id == null ? null : vkMessage?.id,
        fromId: vkMessage?.fromId == null ? null : vkMessage?.fromId,
        date: vkMessage?.date == null ? null : vkMessage?.date,
        text: vkMessage?.text == null ? null : vkMessage?.text,
        fwdMessages: vkMessage?.fwdMessages == null
            ? null
            : List<Message>.from(
                vkMessage.fwdMessages.map((x) => Message.fromVkMessage(x))),
        attachments: vkMessage?.attachments == null
            ? null
            : List<Attachment>.from(vkMessage.attachments
                .map((x) => Attachment.fromVkAttachment(x))),
        latitude: vkMessage?.geo?.coordinates?.latitude == null
            ? null
            : vkMessage?.geo?.coordinates?.latitude,
        longitude: vkMessage?.geo?.coordinates?.longitude == null
            ? null
            : vkMessage?.geo?.coordinates?.longitude,
        place: vkMessage?.geo?.place?.title == null
            ? null
            : vkMessage?.geo?.place?.title,
        isOut: vkMessage?.out == 1,
        isImportant: vkMessage?.important == true,
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
