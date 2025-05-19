part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, loading, success, failure }

final class SignUpState {
  const SignUpState({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.isUsernameUnique,
    required this.password,
    required this.birthdate,
    required this.age,
    required this.phoneNumber,
    required this.email,
    required this.isSubmitting,
    this.status,
    required this.showErrors,
  });

  final Name firstName;
  final Name lastName;
  final Username username;
  final bool isUsernameUnique;
  final Password password;
  final Birthdate birthdate;
  final Age age;
  final PhoneNumber phoneNumber;
  final EmailAddress email;
  final Either<Fail, UserModel>? status;
  final bool isSubmitting;
  final bool showErrors;

  SignUpState copyWith({
    Name? firstName,
    Name? lastName,
    Username? username,
    bool? isUsernameUnique,
    Password? password,
    Birthdate? birthdate,
    Age? age,
    PhoneNumber? phoneNumber,
    EmailAddress? email,
    Either<Fail, UserModel>? status,
    bool isSubmitting = false,
    bool showError = false,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      isUsernameUnique: isUsernameUnique ?? this.isUsernameUnique,
      password: password ?? this.password,
      birthdate: birthdate ?? this.birthdate,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      status: status ?? this.status,
      isSubmitting: isSubmitting,
      showErrors: showError,
    );
  }

  factory SignUpState.initial() {
    return SignUpState(
      firstName: Name(''),
      lastName: Name(''),
      username: Username(''),
      isUsernameUnique: true,
      password: Password(''),
      birthdate: Birthdate(null),
      age: Age(null),
      phoneNumber: PhoneNumber(''),
      email: EmailAddress(''),
      isSubmitting: false,
      showErrors: false,
    );
  }
}
