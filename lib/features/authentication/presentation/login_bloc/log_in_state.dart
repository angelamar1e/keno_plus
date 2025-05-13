part of 'log_in_bloc.dart';

class LogInState {
  const LogInState({
    required this.username,
    required this.password,
    required this.isCorrectPassword,
    required this.status,
  });

  final Username username;
  final Password password;
  final bool? isCorrectPassword;
  final Either<AuthFailure, UserModel>? status;

  LogInState copyWith({
    Username? username,
    Password? password,
    bool? isPasswordCorrect,
    Either<AuthFailure, UserModel>? status,
  }) {
    return LogInState(
      username: username ?? this.username,
      password: password ?? this.password,
      isCorrectPassword: isPasswordCorrect ?? this.isCorrectPassword,
      status: status ?? this.status,
    );
  }

  factory LogInState.initial() {
    return LogInState(
      username: Username(''),
      password: Password(''),
      isCorrectPassword: null,
      status: null,
    );
  }
}
