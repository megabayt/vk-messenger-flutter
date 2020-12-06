part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesState {}

class ProfilesInitial extends ProfilesState {
  final List<Profile> profiles;
  final Map<int, int> profilesMap;

  ProfilesInitial([this.profiles = const []])
      : profilesMap = (() {
          int index = 0;
          return profiles.fold(
            Map<int, int>(),
            (map, conversation) {
              map[conversation.id] = index++;
              return map;
            },
          );
        })();

  Profile getById(int id) {
    final index = getIndexById(id);

    if (index == -1) {
      return null;
    }

    return profiles[index];
  }

  int getIndexById(int id) {
    return profilesMap == null ? null : profilesMap[id] ?? -1;
  }
}
