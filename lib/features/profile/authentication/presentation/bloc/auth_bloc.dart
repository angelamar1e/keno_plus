import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<SwitchToLoginEvent>(_onSwitchToLogin);
    on<SwitchToSignupEvent>(_onSwitchToSignup);
    on<UpdateUserEmailEvent>(_onUpdateUserEmail);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<UpdateUserEmailFocusEvent>(_onUpdateUserEmailFocus);
    on<UpdatePasswordFocusEvent>(_onUpdatePasswordFocus);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ResetPasswordVisibilityEvent>(_onResetPasswordVisibility);
  }

  void _onSwitchToLogin(SwitchToLoginEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(viewType: AuthViewType.login));
  }

  void _onSwitchToSignup(SwitchToSignupEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(viewType: AuthViewType.signup));
  }

  void _onUpdateUserEmail(UpdateUserEmailEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.userEmail));
  }

  void _onUpdatePassword(UpdatePasswordEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onUpdateUserEmailFocus(
    UpdateUserEmailFocusEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isUserEmailFocused: event.isFocused,
        isPasswordFocused: event.isFocused ? false : state.isPasswordFocused,
      ),
    );
  }

  void _onUpdatePasswordFocus(
    UpdatePasswordFocusEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        isPasswordFocused: event.isFocused,
        isUserEmailFocused: event.isFocused ? false : state.isUserEmailFocused,
      ),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onResetPasswordVisibility(
    ResetPasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: false));
  }
}
