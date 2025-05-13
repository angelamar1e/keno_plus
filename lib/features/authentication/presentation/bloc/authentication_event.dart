part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class SwitchToLoginEvent extends AuthenticationEvent {}

class SwitchToSignupEvent extends AuthenticationEvent {}

class UpdateUserEmailEvent extends AuthenticationEvent {
  final String userEmail;
  UpdateUserEmailEvent(this.userEmail);
}

class UpdatePasswordEvent extends AuthenticationEvent {
  final String password;
  UpdatePasswordEvent(this.password);
}

class UpdateUserEmailFocusEvent extends AuthenticationEvent {
  final bool isFocused;
  UpdateUserEmailFocusEvent(this.isFocused);
}

class UpdatePasswordFocusEvent extends AuthenticationEvent {
  final bool isFocused;
  UpdatePasswordFocusEvent(this.isFocused);
}

class TogglePasswordVisibilityEvent extends AuthenticationEvent {}

class ResetPasswordVisibilityEvent extends AuthenticationEvent {}
