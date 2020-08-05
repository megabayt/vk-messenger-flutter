import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/widgets/skeleton.dart';

class ConversationTile extends StatelessWidget {
  final Item _item;

  ConversationTile(this._item);

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Skeleton(),
      );
    }
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage('https://unsplash.it/150/200?random')),
      title: Text(_item.lastMessage.text),
    );
  }
}
