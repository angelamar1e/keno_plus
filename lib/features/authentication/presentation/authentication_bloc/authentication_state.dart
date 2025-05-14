part of 'authentication_bloc.dart';

enum AuthenticationStatus { initial, authenticated, unauthenticated }

class AuthenticationState {
  final AuthenticationStatus status;
  final UserModel? user;

  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.user,
  });

  bool get isAuthenticated => status == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => status == AuthenticationStatus.unauthenticated;
  bool get isCheckingAuthStatus => status == AuthenticationStatus.initial;

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserModel? user,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
