part of 'log_in_bloc.dart';

class LogInState {
  const LogInState({
    required this.username,
    required this.password,
    required this.isSubmitting,
    required this.status,
  });

  final Username username;
  final Password password;
  final bool isSubmitting;
  final Either<AuthFailure, UserModel>? status;

  LogInState copyWith({
    Username? username,
    Password? password,
    bool? isSubmitting,
    Either<AuthFailure, UserModel>? status,
  }) {
    return LogInState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      status: status ?? this.status,
    );
  }

  factory LogInState.initial() {
    return LogInState(
      username: Username(''),
      password: Password(''),
      isSubmitting: false,
      status: null,
    );
  }
}
