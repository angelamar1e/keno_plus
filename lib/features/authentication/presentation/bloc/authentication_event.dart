part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class SwitchToLoginEvent extends AuthenticationEvent {}

class SwitchToSignupEvent extends AuthenticationEvent {}

class CreatingUser extends AuthenticationEvent {
  final User user;

  CreatingUser({required this.user});
}

class UpdateFirstNameEvent extends AuthenticationEvent {
  final String firstName;
  UpdateFirstNameEvent(this.firstName);
}

class UpdateLastNameEvent extends AuthenticationEvent {
  final String lastName;
  UpdateLastNameEvent(this.lastName);
}

class UpdateBirthDateEvent extends AuthenticationEvent {
  final String birthDate;
  UpdateBirthDateEvent(this.birthDate);
}

class UpdateAgeEvent extends AuthenticationEvent {
  final int age;
  UpdateAgeEvent(this.age);
}

class UpdateEmailEvent extends AuthenticationEvent {
  final String email;
  UpdateEmailEvent(this.email);
}

class UpdateUserNameEvent extends AuthenticationEvent {
  final String userName;
  UpdateUserNameEvent(this.userName);
}

class UpdateUserEmailEvent extends AuthenticationEvent {
  final String userEmail;
  UpdateUserEmailEvent(this.userEmail);
}

class UpdatePasswordEvent extends AuthenticationEvent {
  final String password;
  UpdatePasswordEvent(this.password);
}

class TogglePasswordVisibilityEvent extends AuthenticationEvent {}

class ResetPasswordVisibilityEvent extends AuthenticationEvent {}

class UpdateFieldFocusEvent extends AuthenticationEvent {
  final bool isFocused;
  UpdateFieldFocusEvent(this.isFocused);
}
