import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';
import 'package:vk_messenger_flutter/widgets/message.dart';
import 'package:vk_messenger_flutter/widgets/message_date_delimeter.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _itemCreatedHandler(
      ConversationBloc conversationBloc, int index) async {
    final items =
        (conversationBloc?.state as ConversationData)?.currentItems ?? [];

    if (index == items.length - 1) {
      conversationBloc.add(ConversationFetchMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final totalCount = (state as ConversationData)?.currentCount ?? 0;
        var items = (state as ConversationData)?.currentItems ?? [];
        final needFetchMore = totalCount > items.length;

        if (items.length == 0 && (state as ConversationData).isFetching) {
          items = new List(15);
        }

        if (needFetchMore) {
          items = [...items, null, null, null];
        }

        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            conversationBloc.add(ConversationFetch());
          },
          child: ListView.builder(
            reverse: true,
            itemCount: items.length,
            itemBuilder: (BuildContext _, int index) {
              final prevItem = index > 0 ? items[index - 1] : null;

              return CreationAwareListItem(
                key: ValueKey(items[index]?.id),
                itemCreated: () => _itemCreatedHandler(conversationBloc, index),
                child: Provider.value(
                  value: items[index],
                  child: Column(
                    children: <Widget>[
                      Message(),
                      MessageDateDelimeter(prevItem),
                    ],
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
