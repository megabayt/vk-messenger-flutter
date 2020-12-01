part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {}

class ProfilesAppend extends ProfilesEvent {
  final List<dynamic> profiles;
  final List<dynamic> groups;

  ProfilesAppend(this.profiles, this.groups);
}
