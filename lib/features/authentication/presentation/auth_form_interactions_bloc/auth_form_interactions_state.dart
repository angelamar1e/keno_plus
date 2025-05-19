part of 'auth_form_interactions_bloc.dart';

enum AuthViewType { login, signup }

final class AuthFormInteractionsState {
  final AuthViewType viewType;
  final bool isFieldFocused;
  final bool isPasswordVisible;

  const AuthFormInteractionsState({
    this.viewType = AuthViewType.login,
    this.isFieldFocused = false,
    this.isPasswordVisible = false,
  });

  AuthFormInteractionsState copyWith({
    AuthViewType? viewType,
    bool? isFieldFocused,
    bool? isPasswordVisible,
  }) {
    return AuthFormInteractionsState(
      viewType: viewType ?? this.viewType,
      isFieldFocused: isFieldFocused ?? this.isFieldFocused,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
