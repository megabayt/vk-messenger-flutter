import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/message.dart' as MessageModel;
import 'package:vk_messenger_flutter/widgets/message.dart';
import 'package:vk_messenger_flutter/widgets/message_date_delimeter.dart';

class ForwardedMessagesScreen extends StatelessWidget {
  static const routeUrl = '/fwd_messages';

  final List<MessageModel.Message> fwdMessages;

  ForwardedMessagesScreen(this.fwdMessages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пересланные сообщения'),
      ),
      body: ListView.builder(
        itemCount: fwdMessages.length,
        itemBuilder: (BuildContext _, int index) {
          final nextItem =
              index < fwdMessages.length - 1 ? fwdMessages[index + 1] : null;

          return Provider.value(
            value: fwdMessages[index],
            child: Column(
              children: <Widget>[
                MessageDateDelimeter(nextItem),
                Message(),
              ],
            ),
          );
        },
      ),
    );
  }
}
