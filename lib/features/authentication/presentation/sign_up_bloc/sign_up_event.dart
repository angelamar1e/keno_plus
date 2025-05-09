part of 'sign_up_bloc.dart';

sealed class SignUpEvent {
  const SignUpEvent();
}

class FirstNameChanged extends SignUpEvent {
  final String firstName;

  const FirstNameChanged(this.firstName);
}

class LastNameChanged extends SignUpEvent {
  final String lastName;

  const LastNameChanged(this.lastName);
}

class UsernameChanged extends SignUpEvent {
  final String username;

  const UsernameChanged(this.username);
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged(this.password);
}

class BirthdateChanged extends SignUpEvent {
  final DateTime? birthdate;

  const BirthdateChanged(this.birthdate);
}

class AgeChanged extends SignUpEvent {
  final String age;

  const AgeChanged(this.age);
}

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);
}

class EmailChanged extends SignUpEvent {
  final String email;

  const EmailChanged(this.email);
}

class CreatingUser extends SignUpEvent {}
