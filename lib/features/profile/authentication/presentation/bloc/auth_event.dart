part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SwitchToLoginEvent extends AuthEvent {}

class SwitchToSignupEvent extends AuthEvent {}

class UpdateUserEmailEvent extends AuthEvent {
  final String userEmail;
  UpdateUserEmailEvent(this.userEmail);
}

class UpdatePasswordEvent extends AuthEvent {
  final String password;
  UpdatePasswordEvent(this.password);
}

class UpdateUserEmailFocusEvent extends AuthEvent {
  final bool isFocused;
  UpdateUserEmailFocusEvent(this.isFocused);
}

class UpdatePasswordFocusEvent extends AuthEvent {
  final bool isFocused;
  UpdatePasswordFocusEvent(this.isFocused);
}

class TogglePasswordVisibilityEvent extends AuthEvent {}

class ResetPasswordVisibilityEvent extends AuthEvent {}
