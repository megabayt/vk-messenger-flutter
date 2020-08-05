import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/widgets/skeleton.dart';

class ConversationTile extends StatelessWidget {
  final Item _item;

  get _peerId {
    return _item?.conversation?.peer?.id;
  }

  ConversationTile(this._item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatsStore>(context);

    final profiles = provider.data?.response?.profiles ?? [];

    final profile = profiles.firstWhere(
      (profile) => profile.id == _peerId,
      orElse: () => null
    );

    if (_item == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Skeleton(),
      );
    }
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage(profile != null ? profile.photo50 : 'https://unsplash.it/150/200?random')),
      title: Text(profile != null ? profile.lastName : _peerId.toString()),
      subtitle: Text(_item?.lastMessage?.text),
    );
  }
}
