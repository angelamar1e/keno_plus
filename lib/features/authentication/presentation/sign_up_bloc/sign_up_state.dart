part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, loading, success, failure }

final class SignUpState {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.user,
    this.errorMessage,
  });

  final SignUpStatus status;
  final User? user;
  final String? errorMessage;

  bool get isAuthenticated => status == SignUpStatus.success;

  SignUpState copyWith({
    SignUpStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
