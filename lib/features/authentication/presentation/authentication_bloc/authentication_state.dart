part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, loading, success, failure }

final class AuthenticationState {
  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.user,
    this.errorMessage,
  });

  final AuthenticationStatus status;
  final User? user;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthenticationStatus.success;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
