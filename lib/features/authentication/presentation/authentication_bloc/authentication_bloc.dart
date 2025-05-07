import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<AuthenticationSucceeded>(_onAuthenticationSucceeded);
  }

  _onAuthenticationSucceeded(
    AuthenticationSucceeded event,
    Emitter<AuthenticationState> emit,
  ) {
    log(
      'AuthenticationBloc instance in auth bloc : ${sl<AuthenticationBloc>().hashCode}',
    );
    emit(
      state.copyWith(
        status: AuthenticationStatus.authenticated,
        user: event.user,
      ),
    );
    // set the logged in user in the shared preferences
  }
}
