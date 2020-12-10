import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';

import 'package:vk_messenger_flutter/widgets/conversation_avatar.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile_skeleton.dart';

class ConversationTile extends StatelessWidget {
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
    final item = Provider.of<Conversation>(context, listen: false);

    final profile =
        (BlocProvider.of<ProfilesBloc>(context).state as ProfilesInitial)
            .getById(item?.id);

    final name = item?.title ?? profile?.name ?? 'Неизвестно';

    final unreadCount = item?.unreadCount ?? 0;

    final messages = item?.messages ?? [];

    final lastMessage = messages.length != 0 ? messages[0] : null;

    final lastMsgAttachments = lastMessage?.attachments ?? [];
    final lastMsgFwdMessages = lastMessage?.fwdMessages ?? [];

    var text = lastMessage?.text ?? '';

    final outRead = lastMessage?.id == item?.outRead;

    if (text == '') {
      if (lastMsgAttachments.length != 0) {
        text = lastMsgAttachments[0].title ?? '';
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
      trailing: lastMessage?.isOut == true
          ? getOutRead(outRead)
          : getInRead(unreadCount),
    );
  }
}
