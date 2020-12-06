// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FriendsStateCopyWith on FriendsState {
  FriendsState copyWith({
    int count,
    String error,
    bool isFetching,
    List<Profile> items,
    FriendsEvent lastEvent,
  }) {
    return FriendsState(
      count: count ?? this.count,
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
      items: items ?? this.items,
      lastEvent: lastEvent ?? this.lastEvent,
    );
  }
}
