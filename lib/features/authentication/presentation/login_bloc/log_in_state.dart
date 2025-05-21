part of 'log_in_bloc.dart';

class LogInState {
  const LogInState({
    required this.username,
    required this.password,
    required this.isSubmitting,
    required this.showErrors,
    required this.status,
    this.isPasswordVisible = false,
  });

  final Username username;
  final Password password;
  final bool isSubmitting;
  final bool showErrors;
  final Either<AuthFailure, UserModel>? status;
  final bool isPasswordVisible;

  LogInState copyWith({
    Username? username,
    Password? password,
    bool? isSubmitting,
    bool? showErrors,
    Either<AuthFailure, UserModel>? status,
    bool? isPasswordVisible,
  }) {
    return LogInState(
      username: username ?? this.username,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showErrors: showErrors ?? this.showErrors,
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  factory LogInState.initial() {
    return LogInState(
      username: Username(''),
      password: Password(''),
      isSubmitting: false,
      showErrors: false,
      status: null,
      //isPasswordVisible: false,
    );
  }
}
