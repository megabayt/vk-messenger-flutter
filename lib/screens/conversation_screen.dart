import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/widgets/conversation_app_bar.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';

class ConversationScreen extends StatelessWidget {
  static const routeUrl = '/chat';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        return Scaffold(
          appBar: ConversationAppBar(),
          body: MessagesList(),
        );
      },
    );
  }
}
