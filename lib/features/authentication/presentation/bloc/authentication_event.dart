part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class OnCreatingUser extends AuthenticationEvent {
  final User user;

  OnCreatingUser({required this.user});
}
