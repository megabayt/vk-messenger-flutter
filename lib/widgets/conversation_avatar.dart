import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';

class ConversationAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Conversation>(context, listen: false);

    final profile =
        (BlocProvider.of<ProfilesBloc>(context).state as ProfilesInitial)
            .getById(item?.id);

    final activeIds = item?.activeIds ?? [];

    final activeProfiles = activeIds
        .map<String>((activeId) =>
            (BlocProvider.of<ProfilesBloc>(context).state as ProfilesInitial)
                .getById(activeId)
                ?.avatar)
        .toList();

    var avatarUrls =
        activeProfiles.length != 0 ? activeProfiles : [profile.avatar];

    avatarUrls = avatarUrls.where((item) => item != null).toList();

    if (avatarUrls.length == 1) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              avatarUrls[0],
            ),
          ),
          if (profile.isOnline)
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(74, 179, 74, 1),
                shape: BoxShape.circle,
              ),
            ),
        ],
      );
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
