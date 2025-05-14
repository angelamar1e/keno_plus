part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class CheckAuthenticationStatus extends AuthenticationEvent {}

final class AuthenticationSucceeded extends AuthenticationEvent {
  final UserModel user;

  AuthenticationSucceeded({required this.user});
}
