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

    // return Column(
    //   children: <Widget>[
    //     Bubble(
    //       alignment: Alignment.center,
    //       color: Color.fromRGBO(212, 234, 244, 1.0),
    //       child: Text('TODAY',
    //           textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
    //     ),
    //     Bubble(
    //       margin: BubbleEdges.only(top: 10),
    //       alignment: Alignment.topRight,
    //       nip: BubbleNip.rightTop,
    //       color: Color.fromRGBO(225, 255, 199, 1.0),
    //       child: Text('Hello, World!', textAlign: TextAlign.right),
    //     ),
    //     Bubble(
    //       margin: BubbleEdges.only(top: 10),
    //       alignment: Alignment.topLeft,
    //       nip: BubbleNip.leftTop,
    //       child: Text('Hi, developer!'),
    //     ),
    //     Bubble(
    //       margin: BubbleEdges.only(top: 10),
    //       alignment: Alignment.topRight,
    //       nip: BubbleNip.rightBottom,
    //       color: Color.fromRGBO(225, 255, 199, 1.0),
    //       child: Text('Hello, World!', textAlign: TextAlign.right),
    //     ),
    //     Bubble(
    //       margin: BubbleEdges.only(top: 10),
    //       alignment: Alignment.topLeft,
    //       nip: BubbleNip.leftBottom,
    //       child: Text('Hi, developer!'),
    //     ),
    //     Bubble(
    //       margin: BubbleEdges.only(top: 10),
    //       alignment: Alignment.center,
    //       nip: BubbleNip.no,
    //       color: Color.fromRGBO(212, 234, 244, 1.0),
    //       child: Text('TOMORROW',
    //           textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
    //     ),
    //   ],
    // );

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
