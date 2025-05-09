part of 'auth_bloc.dart';

enum AuthViewType { login, signup }

class AuthState {
  final AuthViewType viewType;
  final String email;
  final String password;
  final bool isUserEmailFocused;
  final bool isPasswordFocused;
  final bool isPasswordVisible;

  AuthState({
    this.viewType = AuthViewType.login,
    this.email = '',
    this.password = '',
    this.isUserEmailFocused = false,
    this.isPasswordFocused = false,
    this.isPasswordVisible = false,
  });

  AuthState copyWith({
    AuthViewType? viewType,
    String? email,
    String? password,
    bool? isUserEmailFocused,
    bool? isPasswordFocused,
    bool? isPasswordVisible,
  }) {
    return AuthState(
      viewType: viewType ?? this.viewType,
      email: email ?? this.email,
      password: password ?? this.password,
      isUserEmailFocused: isUserEmailFocused ?? this.isUserEmailFocused,
      isPasswordFocused: isPasswordFocused ?? this.isPasswordFocused,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
