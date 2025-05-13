import 'package:keno_plus/core/values/app_imports.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState()) {
    on<SwitchToLoginEvent>(_onSwitchToLogin);
    on<SwitchToSignupEvent>(_onSwitchToSignup);
    on<UpdateUserEmailEvent>(_onUpdateUserEmail);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<UpdateUserEmailFocusEvent>(_onUpdateUserEmailFocus);
    on<UpdatePasswordFocusEvent>(_onUpdatePasswordFocus);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ResetPasswordVisibilityEvent>(_onResetPasswordVisibility);
  }

  void _onSwitchToLogin(
    SwitchToLoginEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(viewType: AuthenticationViewType.login));
  }

  void _onSwitchToSignup(
    SwitchToSignupEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(viewType: AuthenticationViewType.signup));
  }

  void _onUpdateUserEmail(
    UpdateUserEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(email: event.userEmail));
  }

  void _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onUpdateUserEmailFocus(
    UpdateUserEmailFocusEvent event,
    Emitter<AuthenticationState> emit,
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
    Emitter<AuthenticationState> emit,
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
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onResetPasswordVisibility(
    ResetPasswordVisibilityEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: false));
  }
}
