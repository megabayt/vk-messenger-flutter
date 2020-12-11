import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/message.dart';

part 'message.g.dart';

@CopyWith()
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
    this.replyMessage,
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
  final Message replyMessage;
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
        replyMessage: vkMessage?.replyMessage == null
            ? null
            : Message.fromVkMessage(vkMessage?.replyMessage),
        isOut: vkMessage?.out == 1,
        isImportant: vkMessage?.important == true,
      );
}

extension MessageList on List<Message> {
  List<Message> uniq() {
    final messagesIds = [];
    final newMessages = this.fold<List<Message>>(
      [],
      (previousValue, element) {
        if (messagesIds.contains(element.id)) {
          return previousValue;
        }
        messagesIds.add(element.id);
        return [...previousValue, element];
      },
    );
    return newMessages;
  }
}
