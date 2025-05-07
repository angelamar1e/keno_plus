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
