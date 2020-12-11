import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/local_models/conversation.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';
import 'package:vk_messenger_flutter/widgets/message.dart';
import 'package:vk_messenger_flutter/widgets/message_date_delimeter.dart';
import 'package:vk_messenger_flutter/widgets/message_input.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _itemCreatedHandler(BuildContext context, int index) async {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    final peerId = conversationBloc?.state?.peerId;

    final conversation = BlocProvider.of<ConversationsBloc>(context)
        ?.state
        ?.conversations
        ?.getById(peerId);

    final items = conversation?.messages ?? [];

    if (index == items.length - 1) {
      conversationBloc.add(ConversationFetchMore());
    }
  }

  void _retryHandler(BuildContext context) {
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    conversationBloc.add(ConversationRetry());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (_, conversationsState) {
        return BlocConsumer<ConversationBloc, ConversationState>(
          listener: (_, conversationState) {
            if (conversationState.error != '') {
              final snackBar = SnackBar(
                content: Text(conversationState.error),
                action: SnackBarAction(
                  label: 'Повторить',
                  onPressed: () => _retryHandler(context),
                ),
              );

              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          builder: (_, conversationState) {
            final peerId = conversationState?.peerId;

            final conversation =
                conversationsState?.conversations?.getById(peerId);

            final totalCount = conversation?.messagesCount ?? 0;
            var items = conversation?.messages ?? [];
            final needFetchMore = totalCount > items.length;

            if (items.length == 0 && conversationState.isFetching) {
              items = new List(15);
            }

            if (needFetchMore) {
              items = [...items, null, null, null];
            }

            return Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      BlocProvider.of<ConversationBloc>(context)
                          .add(ConversationFetch());
                    },
                    child: ListView.builder(
                      reverse: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext _, int index) {
                        final nextItem =
                            index < items.length - 1 ? items[index + 1] : null;

                        return CreationAwareListItem(
                          key: ValueKey(items[index]?.id),
                          itemCreated: () =>
                              _itemCreatedHandler(context, index),
                          child: Provider.value(
                            value: items[index],
                            child: Column(
                              children: <Widget>[
                                MessageDateDelimeter(nextItem),
                                Message(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: MessageInput(),
                )
              ],
            );
          },
        );
      },
    );
  }
}
