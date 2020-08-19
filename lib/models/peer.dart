import 'dart:convert';

import 'package:vk_messenger_flutter/utils/enum_values.dart';

class Peer {
  Peer({
    this.id,
    this.type,
    this.localId,
  });

  final int id;
  final PeerType type;
  final int localId;

  factory Peer.fromRawJson(String str) => Peer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Peer.fromJson(Map<String, dynamic> json) => Peer(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : peerTypeValues.map[json["type"]],
        localId: json["local_id"] == null ? null : json["local_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : peerTypeValues.reverse[type],
        "local_id": localId == null ? null : localId,
      };
}

enum PeerType { USER, GROUP, CHAT }

final peerTypeValues = EnumValues({
  "user": PeerType.USER,
  "group": PeerType.GROUP,
  "chat": PeerType.CHAT,
});
