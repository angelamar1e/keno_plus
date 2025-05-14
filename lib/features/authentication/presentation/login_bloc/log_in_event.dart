part of 'log_in_bloc.dart';

class LogInEvent {
  const LogInEvent();
}

class UsernameChanged extends LogInEvent {
  final String username;

  const UsernameChanged(this.username);
}

class PasswordChanged extends LogInEvent {
  final String password;

  const PasswordChanged(this.password);
}

class LoggingIn extends LogInEvent {}
