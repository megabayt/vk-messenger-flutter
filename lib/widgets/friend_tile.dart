import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/local_models/profile.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile_skeleton.dart';

class FriendTile extends StatelessWidget {
  void _friendTapHandler(BuildContext context) {
    final profile = Provider.of<Profile>(context, listen: false);

    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    BlocProvider.of<AttachmentsBloc>(context).add(
      AttachmentsForwardMessage(
        conversationBloc.state.selectedMessagesIds ?? [],
      ),
    );
    AppRouter.sailor.popUntil((route) {
      if (route.settings.name == ConversationsScreen.routeUrl) {
        return true;
      }
      return false;
    });

    conversationBloc.add(ConversationSetPeerId(profile?.id, true));
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context, listen: false);

    if (profile == null) {
      return ConversationTileSkeleton();
    }

    return ListTile(
      onTap: () => _friendTapHandler(context),
      leading: profile?.avatar != null
          ? CircleAvatar(backgroundImage: NetworkImage(profile?.avatar))
          : null,
      title: Text(profile?.name ?? ''),
    );
  }
}
