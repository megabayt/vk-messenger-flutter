import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/models/conversation.dart';
import 'package:vk_messenger_flutter/models/profile.dart';

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
  }

  Profile _profilesMapper(Map<String, dynamic> element, bool isGroup) {
    return Profile(
      id: !isGroup ? element['id'] : -element['id'],
      avatar: element['photo_50'],
      name: !isGroup
          ? '${element['firstName']} ${element['lastName']}'
          : element['name'],
      type: !isGroup ? PeerType.USER : PeerType.GROUP,
      isOnline: element['online'] == 1,
    );
  }

  Stream<ProfilesState> _mapProfilesAppendToState(ProfilesAppend event) async* {
    final profiles = (state as ProfilesInitial).profiles ?? [];

    final newProfiles = event.profiles
        .map((element) => _profilesMapper(element, false))
        .toList();
    final newGroups = event.profiles
        .map((element) => _profilesMapper(element, true))
        .toList();

    yield ProfilesInitial(profiles + newProfiles + newGroups);
  }
}
