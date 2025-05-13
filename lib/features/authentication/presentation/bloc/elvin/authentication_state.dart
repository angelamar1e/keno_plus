part of 'authentication_bloc.dart';

enum AuthenticationViewType { login, signup }

class AuthenticationState {
  final AuthenticationViewType viewType;
  final String email;
  final String password;
  final bool isUserEmailFocused;
  final bool isPasswordFocused;
  final bool isPasswordVisible;

  AuthenticationState({
    this.viewType = AuthenticationViewType.login,
    this.email = '',
    this.password = '',
    this.isUserEmailFocused = false,
    this.isPasswordFocused = false,
    this.isPasswordVisible = false,
  });

  AuthenticationState copyWith({
    AuthenticationViewType? viewType,
    String? email,
    String? password,
    bool? isUserEmailFocused,
    bool? isPasswordFocused,
    bool? isPasswordVisible,
  }) {
    return AuthenticationState(
      viewType: viewType ?? this.viewType,
      email: email ?? this.email,
      password: password ?? this.password,
      isUserEmailFocused: isUserEmailFocused ?? this.isUserEmailFocused,
      isPasswordFocused: isPasswordFocused ?? this.isPasswordFocused,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
