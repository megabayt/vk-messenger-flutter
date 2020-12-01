import 'package:vk_messenger_flutter/models/conversation.dart';

class Profile {
  final int id;
  final String avatar;
  final String name;
  final PeerType type;
  final bool isOnline;

  const Profile({
    this.id,
    this.avatar,
    this.name,
    this.type,
    this.isOnline,
  });

  Profile copyWith({
    int id,
    String avatar,
    String name,
    PeerType type,
    bool isOnline,
  }) =>
      Profile(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        type: type ?? this.type,
        isOnline: isOnline ?? this.isOnline,
      );
}
