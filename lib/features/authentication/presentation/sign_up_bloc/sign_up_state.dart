part of 'sign_up_bloc.dart';

enum SignUpStatus { initial, loading, success, failure }

final class SignUpState {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.user,
    this.errorMessage,
  });

  final SignUpStatus status;
  final UserModel? user;
  final String? errorMessage;

  bool get isSignedUp => status == SignUpStatus.success;
  bool get isFailedSignUp => status == SignUpStatus.failure;

  SignUpState copyWith({
    SignUpStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
