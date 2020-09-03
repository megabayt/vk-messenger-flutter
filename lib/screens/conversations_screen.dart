import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';

class ConversationsScreen extends StatelessWidget {
  static const routeUrl = '/chats';

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  void _itemCreatedHandler(ConversationsBloc conversationsBloc, int index) {
    final items = (conversationsBloc?.state as ConversationsData)?.items ?? [];

    if (index == items.length - 1) {
      conversationsBloc.add(ConversationsFetchMore());
    }
  }

  Function _retryHandler(BuildContext context) => () {
        // ignore: close_sinks
        final conversationBloc = BlocProvider.of<ConversationsBloc>(context);

        conversationBloc.add(ConversationsFetch());
      };

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vk Messenger Flutter'),
      ),
      body: BlocBuilder<ConversationsBloc, ConversationsState>(
        builder: (_, state) {
          if (state is ConversationsError) {
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
          final totalCount = (state as ConversationsData)?.count ?? 0;
          var items = (state as ConversationsData)?.items ?? [];
          final needFetchMore = totalCount > items.length;

          if (items.length == 0 && (state as ConversationsData).isFetching) {
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
                return CreationAwareListItem(
                  key: ValueKey(items[index]?.lastMessage?.id),
                  itemCreated: () =>
                      _itemCreatedHandler(conversationsBloc, index),
                  child: Provider.value(
                    value: items[index],
                    child: ConversationTile(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
