part of 'friends_bloc.dart';

@immutable
abstract class FriendsEvent {}

class FriendsFetch extends FriendsEvent {}

class FriendsFetchMore extends FriendsEvent {}
