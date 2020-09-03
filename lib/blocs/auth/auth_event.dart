part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// Fired just after the app is launched
class UserLogIn extends AuthEvent {}

class UserLogOut extends AuthEvent {}
