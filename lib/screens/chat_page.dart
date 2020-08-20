import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';

class ChatPage extends StatelessWidget {
  static const routeUrl = '/chat';

  final _profilesService = locator<ProfilesService>();
  final int peerId;

  ChatPage(this.peerId);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatStore>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(_profilesService.getProfile(peerId).name),
        ),
        body: FutureBuilder(
          future: provider.getInitialData(peerId),
          builder: (BuildContext _, AsyncSnapshot snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return MessagesList();
          },
        ));
  }
}
