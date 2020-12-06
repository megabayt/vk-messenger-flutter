part of 'friends_bloc.dart';

@immutable
@CopyWith()
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
}
