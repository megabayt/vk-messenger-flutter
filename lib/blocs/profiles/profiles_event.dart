part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {}

class ProfilesAppend extends ProfilesEvent {
  final List<VkProfile> profiles;
  final List<VkProfile> groups;

  ProfilesAppend(this.profiles, this.groups);
}

class ProfilesSetOnline extends ProfilesEvent {
  final int profileId;
  final bool isOnline;

  ProfilesSetOnline(this.profileId, this.isOnline);
}
