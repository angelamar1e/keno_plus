import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/features/authentication/data/models/password.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/data/models/username.dart';
import 'package:keno_plus/features/authentication/domain/usecases/get_by_username_usecase.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final GetUserByUsername getUserByUsername;

  LogInBloc({required this.getUserByUsername}) : super(LogInState.initial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoggingIn>(_onLoggingIn);
  }

  void _onUsernameChanged(
    UsernameChanged event,
    Emitter<LogInState> emit,
  ) async {
    emit(state.copyWith(username: Username(event.username)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LogInState> emit) {
    emit(state.copyWith(password: Password(event.password)));
  }

  void _onLoggingIn(LoggingIn event, Emitter<LogInState> emit) async {
    late Either<AuthFailure, UserModel>? result;

    final isUsernameValid = state.username.value.isRight();
    final isPasswordValid = state.username.value.isRight();

    // Extract valid values
    final String username = state.username.value.getOrElse(() => '');
    final String password = state.password.value.getOrElse(() => '');

    if (isUsernameValid && isPasswordValid) {
      emit(state.copyWith(isSubmitting: true, status: null));

      // get user by username
      result = await getUserByUsername.call(username);

      await Future.delayed(const Duration(seconds: 1));
    }

    if (result != null) {
      result.fold(
        (authFail) => (emit(state.copyWith(status: Left(authFail)))),
        (user) {
          if (user.password == password) {
            emit(state.copyWith(status: Right(user)));
          } else {
            emit(
              state.copyWith(status: Left(AuthFailure.wrongPassword(password))),
            );
          }
        },
      );
    }

    emit(state.copyWith(isSubmitting: false, showErrors: true));
  }
}
