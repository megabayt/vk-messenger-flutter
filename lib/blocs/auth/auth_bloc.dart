import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VKService _vkService = locator<VKService>();

  AuthBloc() : super(AuthNotAuthenticated());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is UserLogIn) {
      yield* _mapUserLogInToState(event);
    }

    if (event is UserLogOut) {
      yield* _mapUserLogOutToState(event);
    }
  }

  Stream<AuthState> _mapUserLogInToState(UserLogIn event) async* {
    yield AuthLoading(); // to display splash screen
    try {
      await _vkService.login();

      yield AuthAuthenticated();
    } catch (e) {
      yield AuthFailure(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthState> _mapUserLogOutToState(UserLogOut event) async* {
    await _vkService.logout();
    yield AuthNotAuthenticated();
  }
}
