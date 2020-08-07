import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/screens/chat_page.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/widgets/conversation_avatar.dart';

class ConversationTile extends StatelessWidget {
  final Item _item;

  get _message {
    if (_item?.lastMessage?.text != '') {
      return _item?.lastMessage?.text;
    }
    return getAttachmentReplacer(_item);
  }

  ConversationTile(this._item);

  void _chatTapHandler(BuildContext context) {
    Navigator.pushNamed(context, ChatPage.routeUrl, arguments: {
      'peerId': _item?.conversation?.peer?.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatsStore>(context);

    final profile = provider.getProfile(_item?.conversation?.peer?.id);

    final name = _item?.conversation?.chatSettings?.title ?? profile.name;

    final unreadCount = _item?.conversation?.unreadCount;

    if (_item == null) {
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
          leading: ConversationAvatar(_item),
          title: Text(name),
          subtitle: Text(
            _message,
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
