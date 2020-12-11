part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesState {}

class ProfilesInitial extends ProfilesState {
  final List<Profile> profiles;

  ProfilesInitial([this.profiles = const []]);
}
