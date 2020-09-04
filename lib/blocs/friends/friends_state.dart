part of 'friends_bloc.dart';

@immutable
abstract class FriendsState {}

class FriendsData extends FriendsState {
  final List<Profile> items;
  final int count;
  final bool isFetching;

  FriendsData({
    this.items = const [],
    this.count = 0,
    this.isFetching = false,
  });

  FriendsData copyWith({
    List<Profile> items,
    int count,
    bool isFetching,
  }) =>
      FriendsData(
        items: items ?? this.items,
        count: count ?? this.count,
        isFetching: isFetching ?? this.isFetching,
      );
}

class FriendsError extends FriendsState {
  final String message;

  FriendsError({@required this.message});
}
