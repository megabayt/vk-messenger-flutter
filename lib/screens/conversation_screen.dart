import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/screens/forward_messages_select.dart';
import 'package:vk_messenger_flutter/screens/router.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/widgets/messages_list.dart';

class ConversationScreen extends StatelessWidget {
  static const routeUrl = '/chat';

  ConversationScreen();

  final _profilesService = locator<ProfilesService>();

  Function _popupMenuHandler(BuildContext context) => (PopupMenuAction action) {
        // ignore: close_sinks
        final conversationBloc = BlocProvider.of<ConversationBloc>(context);

        switch (action) {
          case PopupMenuAction.FORWARD:
            Router.sailor.navigate(ForwardMessagesSelect.routeUrl);
            break;
          case PopupMenuAction.REMOVE:
            conversationBloc.add(ConversationDeleteMessage());
            break;
          case PopupMenuAction.REMOVE_FOR_EVERYONE:
            conversationBloc.add(ConversationDeleteMessage(true));
            break;
          case PopupMenuAction.REPLY:
            conversationBloc.add(ConversationReplyMessage());
            break;
          case PopupMenuAction.MARK_IMPORTANT:
            conversationBloc.add(ConversationMarkImportantMessage());
            break;
          case PopupMenuAction.EDIT:
            conversationBloc.add(ConversationEditMessage());
            break;
        }
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final selectedMessagesIds = state?.selectedMessagesIds ?? [];

        return Scaffold(
          appBar: AppBar(
            title: Text(_profilesService.getProfile(state.peerId).name),
            actions: [
              if (selectedMessagesIds.length > 0)
                PopupMenuButton<PopupMenuAction>(
                  icon: Icon(Icons.more_vert),
                  onSelected: _popupMenuHandler(context),
                  itemBuilder: (BuildContext context) {
                    var singleMessageRows = [];
                    if (selectedMessagesIds.length == 1) {
                      singleMessageRows.addAll([
                        PopupMenuItem(
                          child: Text('Ответить'),
                          value: PopupMenuAction.REPLY,
                        ),
                        PopupMenuItem(
                          child: Text('Пометить как важное'),
                          value: PopupMenuAction.MARK_IMPORTANT,
                        ),
                        PopupMenuItem(
                          child: Text('Редактировать'),
                          value: PopupMenuAction.EDIT,
                        ),
                      ]);
                    }

                    final canRemoveForEveryone =
                        state.selectedMessages.every((element) {
                      final date = DateTime.fromMillisecondsSinceEpoch(
                          element.date * 1000);
                      return element.out == 1 &&
                          DateTime.now().difference(date).inMinutes < 1440;
                    });

                    return [
                      PopupMenuItem(
                        child: Text('Переслать'),
                        value: PopupMenuAction.FORWARD,
                      ),
                      PopupMenuItem(
                        child: Text('Удалить (у меня)'),
                        value: PopupMenuAction.REMOVE,
                      ),
                      if (canRemoveForEveryone)
                        PopupMenuItem(
                          child: Text('Удалить (у всех)'),
                          value: PopupMenuAction.REMOVE_FOR_EVERYONE,
                        ),
                      ...singleMessageRows,
                    ];
                  },
                ),
            ],
          ),
          body: MessagesList(),
        );
      },
    );
  }
}

enum PopupMenuAction {
  FORWARD,
  REMOVE,
  REMOVE_FOR_EVERYONE,
  REPLY,
  MARK_IMPORTANT,
  EDIT,
}
