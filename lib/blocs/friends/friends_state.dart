part of 'friends_bloc.dart';

@immutable
class FriendsState {
  final List<Profile> items;
  final int count;
  final bool isFetching;
  final String error;
  final FriendsEvent lastEvent;

  FriendsState({
    this.items = const [],
    this.count = 0,
    this.isFetching = false,
    this.error = '',
    this.lastEvent,
  });

  FriendsState copyWith({
    List<Profile> items,
    int count,
    bool isFetching,
    String error,
    FriendsEvent lastEvent,
  }) =>
      FriendsState(
        items: items ?? this.items,
        count: count ?? this.count,
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        lastEvent: lastEvent ?? this.lastEvent,
      );
}
