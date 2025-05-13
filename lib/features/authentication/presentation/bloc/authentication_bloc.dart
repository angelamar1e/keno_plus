import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';
import 'package:keno_plus/features/authentication/domain/use_cases/create_user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser createUser;

  AuthenticationBloc({required this.createUser})
    : super(AuthenticationState()) {
    on<CreatingUser>(_onCreatingUser);
  }

  _onCreatingUser(CreatingUser event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: AuthenticationStatus.loading));
    final result = await createUser(event.user);
    result.fold(
      (l) {
        emit(
          state.copyWith(
            status: AuthenticationStatus.failure,
            errorMessage: l.failure.toString(),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            status: AuthenticationStatus.success,
            user: event.user,
          ),
        );
      },
    );
  }
}
