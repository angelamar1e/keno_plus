part of 'auth_form_interactions_bloc.dart';

abstract class AuthFormInteractionsEvent {
  const AuthFormInteractionsEvent();
}

class SwitchToLoginEvent extends AuthFormInteractionsEvent {}

class SwitchToSignupEvent extends AuthFormInteractionsEvent {}

class TogglePasswordVisibilityEvent extends AuthFormInteractionsEvent {}

class ResetPasswordVisibilityEvent extends AuthFormInteractionsEvent {}

class UpdateFieldFocusEvent extends AuthFormInteractionsEvent {
  final bool isFocused;
  UpdateFieldFocusEvent(this.isFocused);
}
