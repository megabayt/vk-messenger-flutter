import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart'
    show VkConversationItem;
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/widgets/conversation_avatar.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile_skeleton.dart';

class ConversationTile extends StatelessWidget {
  final _profilesService = locator<ProfilesService>();

  Widget getOutRead(bool outRead) {
    if (outRead) {
      return null;
    }
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: Color.fromRGBO(147, 173, 200, .9),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      padding: EdgeInsets.all(7),
      child: null,
    );
  }

  Widget getInRead(int unreadCount) {
    if (unreadCount == 0) {
      return null;
    }
    return Badge(
      padding: EdgeInsets.all(7),
      badgeContent: Text(
        unreadCount.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      child: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<VkConversationItem>(context, listen: false);

    final profile = _profilesService.getProfile(item?.conversation?.peer?.id);

    final name = item?.conversation?.chatSettings?.title ?? profile.name;

    final unreadCount = item?.conversation?.unreadCount ?? 0;

    final lastMsgAttachments = item?.lastMessage?.attachments ?? [];
    final lastMsgFwdMessages = item?.lastMessage?.fwdMessages ?? [];

    var text = item?.lastMessage?.text;

    final isOut = item?.lastMessage?.out == 1;
    final outRead = item?.lastMessage?.id == item?.conversation?.outRead;

    if (text == '') {
      if (lastMsgAttachments.length != 0) {
        text = getAttachmentReplacer(lastMsgAttachments[0]);
      }
      if (lastMsgFwdMessages.length != 0) {
        text = 'Пересланные сообщения';
      }
    }

    if (item == null) {
      return ConversationTileSkeleton();
    }

    return ListTile(
      leading: ConversationAvatar(),
      title: Text(name),
      subtitle: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: isOut ? getOutRead(outRead) : getInRead(unreadCount),
    );
  }
}
