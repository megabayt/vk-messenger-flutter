import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/local_models/profile.dart';
import 'package:vk_messenger_flutter/vk_models/profile.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  ProfilesBloc() : super(ProfilesInitial());

  @override
  Stream<ProfilesState> mapEventToState(
    ProfilesEvent event,
  ) async* {
    if (event is ProfilesAppend) {
      yield* _mapProfilesAppendToState(event);
    }
    if (event is ProfilesSetOnline) {
      yield* _mapProfilesSetOnlineToState(event);
    }
  }

  Stream<ProfilesState> _mapProfilesAppendToState(ProfilesAppend event) async* {
    final profiles = (state as ProfilesInitial).profiles ?? [];

    final newProfiles = event.profiles
        .map((element) => Profile.fromVkProfile(element, false))
        .toList();
    final newGroups = event.groups
        .map((element) => Profile.fromVkProfile(element, true))
        .toList();

    yield ProfilesInitial(profiles + newProfiles + newGroups);
  }

  Stream<ProfilesState> _mapProfilesSetOnlineToState(
      ProfilesSetOnline event) async* {
    final profiles = (state as ProfilesInitial).profiles ?? [];

    final newProfiles = profiles.map((element) {
      if (element.id == event.profileId) {
        return element.copyWith(isOnline: event.isOnline);
      }
      return element;
    }).toList();

    yield ProfilesInitial(newProfiles);
  }
}
