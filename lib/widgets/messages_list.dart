import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/store/chat_store.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';
import 'package:vk_messenger_flutter/widgets/message.dart';
import 'package:vk_messenger_flutter/widgets/message_date_delimeter.dart';

class MessagesList extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _itemCreatedHandler(ChatStore provider, int index) async {
    final items = provider?.data?.response?.items ?? [];

    if (index == items.length - 1) {
      await provider.getNextData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatStore>(context);

    final peerId = provider.peerId;

    final totalCount = provider?.data?.response?.count ?? 0;
    var items = provider?.data?.response?.items ?? [];
    final needFetchMore = totalCount > items.length;

    if (needFetchMore) {
      items = [...items, null];
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => provider.getInitialData(peerId),
      child: ListView.builder(
        reverse: true,
        itemCount: items.length,
        itemBuilder: (BuildContext _, int index) {
          final prevItem = index > 0 ? items[index - 1] : null;

          return CreationAwareListItem(
              key: ValueKey(items[index]?.id),
              itemCreated: () => _itemCreatedHandler(provider, index),
              child: Provider.value(
                value: items[index],
                child: Column(
                  children: <Widget>[
                    Message(),
                    MessageDateDelimeter(prevItem),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
