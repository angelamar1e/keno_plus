part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class CreatingUser extends AuthenticationEvent {
  final User user;

  CreatingUser({required this.user});
}
