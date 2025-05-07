part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class CheckAuthenticationStatus extends AuthenticationEvent {}

final class AuthenticationSucceeded extends AuthenticationEvent {
  final User user;

  AuthenticationSucceeded({required this.user});
}
