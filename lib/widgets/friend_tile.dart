import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/models/profile.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/router.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile_skeleton.dart';

class FriendTile extends StatelessWidget {
  Function _friendTapHandler(BuildContext context) => () {
        final profile = Provider.of<Profile>(context, listen: false);

        // ignore: close_sinks
        final conversationBloc = BlocProvider.of<ConversationBloc>(context);

        conversationBloc.add(ConversationForwardMessage());
        Router.sailor.popUntil((route) {
          if (route.settings.name == ConversationsScreen.routeUrl) {
            return true;
          }
          return false;
        });

        conversationBloc.add(ConversationSetPeerId(profile?.id));
      };

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context, listen: false);

    final name = '${profile?.firstName} ${profile?.lastName}';

    final avatar = profile?.photo50;

    if (profile == null) {
      return ConversationTileSkeleton();
    }

    return ListTile(
      onTap: _friendTapHandler(context),
      leading: avatar != null
          ? CircleAvatar(backgroundImage: NetworkImage(avatar))
          : null,
      title: Text(name),
    );
  }
}
