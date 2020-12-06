import 'package:vk_messenger_flutter/vk_models/peer_type.dart';

class VkPeer {
  VkPeer({
    this.id,
    this.type,
    this.localId,
  });

  final int id;
  final VkPeerType type;
  final int localId;

  factory VkPeer.fromMap(Map<String, dynamic> json) => VkPeer(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : vkPeerTypeValues.map[json["type"]],
        localId: json["local_id"] == null ? null : json["local_id"],
      );
}
