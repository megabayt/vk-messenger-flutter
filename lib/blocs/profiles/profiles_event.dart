part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {}

class ProfilesAppend extends ProfilesEvent {
  final List<Map<String, dynamic>> profiles;
  final List<Map<String, dynamic>> groups;

  ProfilesAppend(this.profiles, this.groups);
}
 