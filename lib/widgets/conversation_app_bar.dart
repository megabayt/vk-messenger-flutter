import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vk_messenger_flutter/screens/forward_messages_select.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/services/interfaces/profiles_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

class ConversationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  ConversationAppBar({
    this.bottom,
    this.toolbarHeight,
  });

  final PreferredSizeWidget bottom;
  final double toolbarHeight;

  get preferredSize {
    return Size.fromHeight(toolbarHeight ??
        kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
  }

  final _profilesService = locator<ProfilesService>();

  void _popupMenuHandler(
      BuildContext context, ConversationAppBarMenuAction action) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    switch (action) {
      case ConversationAppBarMenuAction.FORWARD:
        AppRouter.sailor.navigate(ForwardMessagesSelect.routeUrl);
        break;
      case ConversationAppBarMenuAction.REMOVE:
        conversationBloc.add(ConversationDeleteMessage());
        break;
      case ConversationAppBarMenuAction.REMOVE_FOR_EVERYONE:
        conversationBloc.add(ConversationDeleteMessage(true));
        break;
      case ConversationAppBarMenuAction.REPLY:
        conversationBloc.add(ConversationReplyMessage());
        break;
      case ConversationAppBarMenuAction.MARK_IMPORTANT:
        conversationBloc.add(ConversationMarkImportantMessage());
        break;
      case ConversationAppBarMenuAction.EDIT:
        conversationBloc.add(ConversationEditMessage());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final selectedMessagesIds = state?.selectedMessagesIds ?? [];
        return AppBar(
          title: Text(_profilesService.getProfile(state.peerId).name),
          actions: [
            if (selectedMessagesIds.length > 0)
              PopupMenuButton<ConversationAppBarMenuAction>(
                icon: Icon(Icons.more_vert),
                onSelected: (action) => _popupMenuHandler(context, action),
                itemBuilder: (BuildContext context) {
                  var singleMessageRows = [];
                  if (selectedMessagesIds.length == 1) {
                    singleMessageRows.addAll([
                      PopupMenuItem(
                        child: Text('Ответить'),
                        value: ConversationAppBarMenuAction.REPLY,
                      ),
                      PopupMenuItem(
                        child: Text('Пометить как важное'),
                        value: ConversationAppBarMenuAction.MARK_IMPORTANT,
                      ),
                      PopupMenuItem(
                        child: Text('Редактировать'),
                        value: ConversationAppBarMenuAction.EDIT,
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
                      value: ConversationAppBarMenuAction.FORWARD,
                    ),
                    PopupMenuItem(
                      child: Text('Удалить (у меня)'),
                      value: ConversationAppBarMenuAction.REMOVE,
                    ),
                    if (canRemoveForEveryone)
                      PopupMenuItem(
                        child: Text('Удалить (у всех)'),
                        value: ConversationAppBarMenuAction.REMOVE_FOR_EVERYONE,
                      ),
                    ...singleMessageRows,
                  ];
                },
              ),
          ],
        );
      },
    );
  }
}

enum ConversationAppBarMenuAction {
  FORWARD,
  REMOVE,
  REMOVE_FOR_EVERYONE,
  REPLY,
  MARK_IMPORTANT,
  EDIT,
}
