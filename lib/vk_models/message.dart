import 'package:vk_messenger_flutter/vk_models/attachment.dart';
import 'package:vk_messenger_flutter/vk_models/geo.dart';

class VkMessage {
  VkMessage({
    this.id,
    this.fromId,
    this.date,
    this.out,
    this.peerId,
    this.text,
    this.fwdMessages,
    this.important,
    this.attachments,
    this.replyMessage,
    this.geo,
    this.isSent = true,
    this.isError = false,
  });

  final int date;
  final int fromId;
  final int id;
  final int out;
  final int peerId;
  final String text;
  final List<VkMessage> fwdMessages;
  final bool important;
  final List<VkAttachment> attachments;
  final VkGeo geo;
  final VkMessage replyMessage;
  final bool isSent;
  final bool isError;

  factory VkMessage.fromMap(Map<String, dynamic> json) => VkMessage(
        date: json["date"] == null ? null : json["date"],
        fromId: json["from_id"] == null ? null : json["from_id"],
        id: json["id"] == null ? null : json["id"],
        out: json["out"] == null ? null : json["out"],
        peerId: json["peer_id"] == null ? null : json["peer_id"],
        text: json["text"] == null ? null : json["text"],
        fwdMessages: json["fwd_messages"] == null
            ? null
            : List<VkMessage>.from(
                json["fwd_messages"].map((x) => VkMessage.fromMap(x))),
        important: json["important"] == null ? null : json["important"],
        attachments: json["attachments"] == null
            ? null
            : List<VkAttachment>.from(
                json["attachments"].map((x) => VkAttachment.fromMap(x))),
        geo: json["geo"] == null ? null : VkGeo.fromMap(json["geo"]),
        replyMessage: json["reply_message"] == null
            ? null
            : VkMessage.fromMap(json["reply_message"]),
      );
}
