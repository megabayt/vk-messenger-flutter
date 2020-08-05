import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/widgets/conversation_tile.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';

class ConversationList extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _itemCreatedHandler(ChatsStore provider, int index) async {
    final items = provider?.data?.response?.items ?? [];

    if (index == items.length - 1) {
      await provider.getNextData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatsStore>(context);

    final totalCount = provider?.data?.response?.count ?? 0;
    var items = provider?.data?.response?.items ?? [];
    final needFetchMore = totalCount > items.length;

    if (needFetchMore) {
      items = [...items, null];
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: provider.getInitialData,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext _, int index) {
          return CreationAwareListItem(
            key: ValueKey(items[index]?.lastMessage?.id),
            itemCreated: () => _itemCreatedHandler(provider, index),
            child: ConversationTile(
              items[index],
            ),
          );
        },
      ),
    );
  }
}
