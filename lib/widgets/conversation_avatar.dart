import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/vk_conversations.dart' show Item;
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

class ConversationAvatar extends StatelessWidget {
  final _profilesService = locator<ProfilesService>();

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    final profile = _profilesService.getProfile(item?.conversation?.peer?.id);

    final activeIds = item?.conversation?.chatSettings?.activeIds ?? [];

    final activeProfiles = activeIds
        .map<String>((activeId) => _profilesService.getProfile(activeId)?.avatar)
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
