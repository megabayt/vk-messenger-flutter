import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/models/vk_conversations.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/router.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';

class ConversationsList extends StatelessWidget {
  final bool fwdSelectMode;
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  ConversationsList({this.fwdSelectMode = false});

  void _itemCreatedHandler(ConversationsBloc conversationsBloc, int index) {
    final items = conversationsBloc?.state?.items ?? [];

    if (index == items.length - 1) {
      conversationsBloc.add(ConversationsFetchMore());
    }
  }

  void _retryHandler(BuildContext context) {
    // ignore: close_sinks
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    conversationsBloc.add(ConversationsFetch());
  }

  void _chatTapHandler(BuildContext context, VkConversationItem item) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    if (fwdSelectMode) {
      conversationBloc.add(ConversationForwardMessage());
      Router.sailor.popUntil((route) {
        if (route.settings.name == ConversationsScreen.routeUrl) {
          return true;
        }
        return false;
      });
    }

    conversationBloc.add(ConversationSetPeerId(item?.conversation?.peer?.id));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    return BlocConsumer<ConversationsBloc, ConversationsState>(
      listener: (_, state) {
        if (state.error != null) {
          final snackBar = SnackBar(
            content: Text(state.error),
            action: SnackBarAction(
              label: 'Повторить',
              onPressed: () => _retryHandler(context),
            ),
          );

          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      builder: (_, state) {
        final totalCount = state?.count ?? 0;
        var items = state?.items ?? [];
        final needFetchMore = totalCount > items.length;

        if (items.length == 0 && state.isFetching) {
          items = new List(15);
        }

        if (needFetchMore) {
          items = [...items, null, null, null];
        }

        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            conversationsBloc.add(ConversationsFetch());
          },
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext _, int index) {
              return InkWell(
                onTap: () => _chatTapHandler(context, items[index]),
                child: CreationAwareListItem(
                  key: ValueKey(items[index]?.lastMessage?.id),
                  itemCreated: () =>
                      _itemCreatedHandler(conversationsBloc, index),
                  child: Provider.value(
                    value: items[index],
                    child: ConversationTile(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
