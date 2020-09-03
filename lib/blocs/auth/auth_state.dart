part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {}

class AuthNotAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({@required this.message});
}
