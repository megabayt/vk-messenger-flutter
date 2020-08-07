import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/screens/chat_page.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/widgets/conversation_avatar.dart';

class ConversationTile extends StatelessWidget {
  void _chatTapHandler(BuildContext context) {
    final item = Provider.of<Item>(context);
    Navigator.pushNamed(context, ChatPage.routeUrl, arguments: {
      'peerId': item?.conversation?.peer?.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    final getProfile = Provider.of<ChatsStore>(context).getProfile;

    final profile = getProfile(item?.conversation?.peer?.id);

    final name = item?.conversation?.chatSettings?.title ?? profile.name;

    final unreadCount = item?.conversation?.unreadCount;

    if (item == null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Material(
      child: InkWell(
        onTap: () => _chatTapHandler(context),
        child: ListTile(
          leading: ConversationAvatar(),
          title: Text(name),
          subtitle: Text(
            item?.lastMessage?.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: unreadCount != null
              ? Badge(
                  padding: EdgeInsets.all(7),
                  badgeContent: Text(
                    unreadCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: null,
                )
              : null,
        ),
      ),
    );
  }
}
