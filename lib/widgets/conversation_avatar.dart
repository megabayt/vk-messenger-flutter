import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/store/chats_store.dart';

class ConversationAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    final getProfile = Provider.of<ChatsStore>(context).getProfile;

    final profile = getProfile(item?.conversation?.peer?.id);

    final activeIds = item?.conversation?.chatSettings?.activeIds ?? [];

    final activeProfiles = activeIds
        .map<String>((activeId) => getProfile(activeId)?.avatar)
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
