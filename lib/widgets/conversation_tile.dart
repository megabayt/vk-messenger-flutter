import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/screens/chat_page.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/widgets/conversation_avatar.dart';

class ConversationTile extends StatelessWidget {
  final _profilesService = locator<ProfilesService>();

  void _chatTapHandler(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    Navigator.pushNamed(context, ChatPage.routeUrl, arguments: {
      'peerId': item?.conversation?.peer?.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    final profile = _profilesService.getProfile(item?.conversation?.peer?.id);

    final name = item?.conversation?.chatSettings?.title ?? profile.name;

    final unreadCount = item?.conversation?.unreadCount;

    final lastMsgAttachments = item?.lastMessage?.attachments ?? [];
    final lastMsgFwdMessages = item?.lastMessage?.fwdMessages ?? [];

    var text = item?.lastMessage?.text;

    if (text == '') {
      if (lastMsgAttachments.length != 0) {
        text = getAttachmentReplacer(lastMsgAttachments[0]);
      }
      if (lastMsgFwdMessages.length != 0) {
        text = 'Пересланные сообщения';
      }
    }

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
            text,
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
