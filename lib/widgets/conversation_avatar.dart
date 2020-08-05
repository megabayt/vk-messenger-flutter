import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';

class ConversationAvatar extends StatelessWidget {
  final Item _item;

  ConversationAvatar(this._item);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatsStore>(context);

    final profile = provider.getProfile(_item?.conversation?.peer?.id);

    final activeIds = _item?.conversation?.chatSettings?.activeIds ?? [];

    final activeProfiles = activeIds
        .map<String>((activeId) => provider.getProfile(activeId)?.avatar)
        .toList();

    var avatarUrls = activeProfiles.length != 0 ? activeProfiles : [profile.avatar];

    avatarUrls = avatarUrls.where((item) => item != null).toList();

    if (avatarUrls.length == 1) {
      return CircleAvatar(backgroundImage: NetworkImage(avatarUrls[0]));
    }
    return Container(
      height: 40.0,
      width: 40.0,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: avatarUrls.map((avatar) {
          return CircleAvatar(backgroundImage: NetworkImage(avatar));
        }).toList(),
      ),
    );
  }
}
