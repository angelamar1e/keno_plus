import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/usecases/get_by_username_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.getUser) : super(AuthenticationState()) {
    on<AuthenticationSucceeded>(_onAuthenticationSucceeded);
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
  }

  final GetUserByUsername getUser;

  _onAuthenticationSucceeded(
    AuthenticationSucceeded event,
    Emitter<AuthenticationState> emit,
  ) async {
    // Save the username in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUser', event.user.username);

    emit(
      state.copyWith(
        status: AuthenticationStatus.authenticated,
        user: event.user,
      ),
    );
    // set the logged in user in the shared preferences
  }

  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthenticationState> emit,
  ) async {
    // delay
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedInUser');

    UserModel? user;
    AuthenticationStatus status = AuthenticationStatus.unauthenticated;

    if (username != null) {
      final result = await getUser.call(username);

      result.fold(
        (fail) => {status = AuthenticationStatus.unauthenticated},
        (user) => {status = AuthenticationStatus.authenticated, user = user},
      );
    }

    emit(state.copyWith(status: status, user: user));
  }
}
