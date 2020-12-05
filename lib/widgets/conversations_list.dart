import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile.dart';

class ConversationsList extends StatelessWidget {
  final bool fwdSelectMode;
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  ConversationsList({this.fwdSelectMode = false});

  void _itemCreatedHandler(
      BuildContext context, ConversationsState state, int index) {
    final items = state?.conversations ?? [];

    if (index == items.length - 1) {
      BlocProvider.of<ConversationsBloc>(context).add(ConversationsFetchMore());
    }
  }

  void _retryHandler(BuildContext context) {
    // ignore: close_sinks
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    conversationsBloc.add(ConversationsRetry());
  }

  void _chatTapHandler(BuildContext context, Conversation item) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);
    if (fwdSelectMode) {
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
    }

    AppRouter.sailor.navigate(ConversationScreen.routeUrl);

    conversationBloc.add(
      ConversationSetPeerId(
        item?.id,
        fwdSelectMode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConversationsBloc, ConversationsState>(
      listener: (_, state) {
        if (state.error != '') {
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
        var conversations = state?.conversations ?? [];
        final needFetchMore = totalCount > conversations.length;

        if (conversations.length == 0 && state.isFetching) {
          conversations = new List(15);
        }

        if (needFetchMore) {
          conversations = [...conversations, null, null, null];
        }

        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            BlocProvider.of<ConversationsBloc>(context)
                .add(ConversationsFetch());
          },
          child: ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (BuildContext _, int index) {
              return InkWell(
                onTap: () => _chatTapHandler(context, conversations[index]),
                child: CreationAwareListItem(
                  key: ValueKey(conversations[index]?.id),
                  itemCreated: () => _itemCreatedHandler(context, state, index),
                  child: Provider.value(
                    value: conversations[index],
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
