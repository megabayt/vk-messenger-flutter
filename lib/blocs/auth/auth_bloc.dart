import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/splash_screen.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VKService _vkService = locator<VKService>();
  final ConversationsBloc _conversationsBloc;

  AuthBloc(ConversationsBloc conversationsBloc)
      : _conversationsBloc = conversationsBloc,
        super(AuthNotAuthenticated());

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    if (transition.nextState is AuthNotAuthenticated ||
        transition.nextState is AuthFailure) {
      AppRouter.sailor.popUntil((_) => false);
      AppRouter.sailor.navigate(SplashScreen.routeUrl);
      this.add(UserLogIn());
    }
    if (transition.nextState is AuthAuthenticated) {
      AppRouter.sailor.popUntil((_) => false);
      AppRouter.sailor.navigate(ConversationsScreen.routeUrl);
      _conversationsBloc.add(ConversationsFetch());
    }
    super.onTransition(transition);
  }

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
