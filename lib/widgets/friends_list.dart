import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/blocs/friends/friends_bloc.dart';
import 'package:vk_messenger_flutter/widgets/friend_tile.dart';
import 'package:vk_messenger_flutter/widgets/creation_aware_list_item.dart';

class FriendsList extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  void _itemCreatedHandler(FriendsBloc friendsBloc, int index) {
    final items = friendsBloc?.state?.items ?? [];

    if (index == items.length - 1) {
      friendsBloc.add(FriendsFetchMore());
    }
  }

  void _retryHandler(BuildContext context) {
    // ignore: close_sinks
    final friendsBloc = BlocProvider.of<FriendsBloc>(context);

    friendsBloc.add(FriendsFetch());
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final friendsBloc = BlocProvider.of<FriendsBloc>(context);

    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (_, state) {
        if (state.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(state.error),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                RaisedButton(
                  onPressed: () => _retryHandler(context),
                  child: Text('Повторить'),
                )
              ],
            ),
          );
        }
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
            friendsBloc.add(FriendsFetch());
          },
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext _, int index) {
              return InkWell(
                // onTap: _chatTapHandler(context, items[index]),
                child: CreationAwareListItem(
                  key: ValueKey(items[index]?.id),
                  itemCreated: () => _itemCreatedHandler(friendsBloc, index),
                  child: Provider.value(
                    value: items[index],
                    child: FriendTile(),
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
