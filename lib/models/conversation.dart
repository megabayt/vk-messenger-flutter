import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/utils/enum_values.dart';
import 'package:map_path/map_path.dart';

class Conversation {
  Conversation({
    this.id,
    this.type,
    this.localId,
    this.unreadCount,
    this.messages,
    this.activeIds,
    this.title,
    this.inRead,
    this.outRead,
  });

  final int id;
  final PeerType type;
  final int localId;
  final int unreadCount;
  final List<Message> messages;
  final List<int> activeIds;
  final String title;
  final int inRead;
  final int outRead;

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: mapPath(json, ['conversation', 'peer', 'id']),
        type: mapPath(json, ['conversation', 'peer', 'type']) == null
            ? null
            : peerTypeValues
                .map[mapPath(json, ['conversation', 'peer', 'type'])],
        localId: mapPath(json, ['conversation', 'peer', 'local_id']),
        activeIds: mapPath(
                    json, ['conversation', 'chat_settings', 'active_ids']) ==
                null
            ? null
            : List<int>.from(
                mapPath(json, ['conversation', 'chat_settings', 'active_ids'])
                    .map((x) => x)),
        title: mapPath(json, ['conversation', 'chat_settings', 'title']),
        unreadCount: mapPath(json, ['conversation', 'unread_count']),
        messages: json['last_message'] == null
            ? []
            : [Message.fromJson(json['last_message'])],
        inRead: mapPath(json, ['conversation', 'in_read']),
        outRead: mapPath(json, ['conversation', 'out_read']),
      );

  Conversation copyWith({
    int id,
    PeerType type,
    int localId,
    int unreadCount,
    List<Message> messages,
    List<int> activeIds,
    String title,
    int inRead,
    int outRead,
  }) {
    return Conversation(
      id: id ?? this.id,
      type: type ?? this.type,
      localId: localId ?? this.localId,
      unreadCount: unreadCount ?? this.unreadCount,
      messages: messages ?? this.messages,
      activeIds: activeIds ?? this.activeIds,
      title: title ?? this.title,
      inRead: inRead ?? this.inRead,
      outRead: outRead ?? this.outRead,
    );
  }
}

enum PeerType { USER, GROUP, CHAT }

final peerTypeValues = EnumValues({
  'user': PeerType.USER,
  'group': PeerType.GROUP,
  'chat': PeerType.CHAT,
});
