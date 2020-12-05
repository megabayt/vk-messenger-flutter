part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {}

class ProfilesAppend extends ProfilesEvent {
  final List<VkProfile> profiles;
  final List<VkProfile> groups;

  ProfilesAppend(this.profiles, this.groups);
}
