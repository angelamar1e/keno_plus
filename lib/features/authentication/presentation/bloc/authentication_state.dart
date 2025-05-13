part of 'authentication_bloc.dart';

enum AuthenticationViewType { login, signup }

enum AuthenticationStatus { initial, loading, success, failure }

final class AuthenticationState {
  final AuthenticationViewType viewType;
  final String firstName;
  final String lastName;
  final String birthDate;
  final int age;
  final String email;
  final String password;
  final bool isFieldFocused;
  final bool isPasswordVisible;
  final String userName;
  final AuthenticationStatus status;
  final User? user;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthenticationStatus.success;

  const AuthenticationState({
    this.viewType = AuthenticationViewType.login,
    this.firstName = '',
    this.lastName = '',
    this.birthDate = '',
    this.age = 0,
    this.email = '',
    this.password = '',
    this.isFieldFocused = false,
    this.isPasswordVisible = false,
    this.status = AuthenticationStatus.initial,
    this.user,
    this.errorMessage,
    this.userName = '',
  });

  AuthenticationState copyWith({
    AuthenticationViewType? viewType,
    String? firstName,
    String? lastName,
    String? birthDate,
    int? age,
    String? userName,
    String? email,
    String? password,
    bool? isFieldFocused,
    bool? isPasswordVisible,
    AuthenticationStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthenticationState(
      viewType: viewType ?? this.viewType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      userName: userName ?? this.userName,
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      isFieldFocused: isFieldFocused ?? this.isFieldFocused,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
