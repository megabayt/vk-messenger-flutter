import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';
import 'package:vk_messenger_flutter/widgets/message_input.dart';

class ConversationScreen extends StatelessWidget {
  static const routeUrl = '/chat';

  ConversationScreen();

  final _profilesService = locator<ProfilesService>();

  Function _retryHandler(BuildContext context) => () {
        // ignore: close_sinks
        final conversationBloc = BlocProvider.of<ConversationBloc>(context);

        conversationBloc.add(ConversationFetch());
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        if (state is ConversationError) {
          return Center(
            child: Column(
              children: <Widget>[
                Text(state.message),
                RaisedButton(
                  onPressed: _retryHandler(context),
                  child: Text('Повторить'),
                )
              ],
            ),
          );
        }
        final showEmojiKeyboard = (state as ConversationData).showEmojiKeyboard;

        final statusBarHeight = MediaQuery.of(context).padding.top;
        final appBarHeight = AppBar().preferredSize.height;
        final screenHeight = MediaQuery.of(context).size.height;
        final bottomOffset = MediaQuery.of(context).viewInsets.bottom;
        final emojiKeyboardHeight = showEmojiKeyboard ? 215.0 : 0.0;

        final inputHeight = 50.0 + emojiKeyboardHeight;

        final messagesListHeight = screenHeight -
            appBarHeight -
            statusBarHeight -
            bottomOffset -
            inputHeight;

        return Scaffold(
          appBar: AppBar(
            title: Text(_profilesService
                .getProfile((state as ConversationData).peerId)
                .name),
          ),
          body: Column(
            children: <Widget>[
              Container(
                height: messagesListHeight,
                child: MessagesList(),
              ),
              Container(
                width: double.infinity,
                height: inputHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .1),
                      blurRadius: 10,
                      offset: Offset.zero,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: MessageInput(),
              )
            ],
          ),
        );
      },
    );
  }
}
