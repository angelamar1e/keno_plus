import 'package:keno_plus/core/values/app_imports.dart';

part 'auth_form_interactions_event.dart';
part 'auth_form_interactions_state.dart';

class AuthFormInteractionsBloc
    extends Bloc<AuthFormInteractionsEvent, AuthFormInteractionsState> {
  AuthFormInteractionsBloc() : super(AuthFormInteractionsState()) {
    on<SwitchToLoginEvent>(_onSwitchToLogin);
    on<SwitchToSignupEvent>(_onSwitchToSignup);
    on<UpdateFieldFocusEvent>(_onUpdateFieldFocus);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ResetPasswordVisibilityEvent>(_onResetPasswordVisibility);
  }

  void _onSwitchToLogin(
    SwitchToLoginEvent event,
    Emitter<AuthFormInteractionsState> emit,
  ) {
    emit(state.copyWith(viewType: AuthViewType.login));
  }

  void _onSwitchToSignup(
    SwitchToSignupEvent event,
    Emitter<AuthFormInteractionsState> emit,
  ) {
    emit(state.copyWith(viewType: AuthViewType.signup));
  }

  void _onUpdateFieldFocus(
    UpdateFieldFocusEvent event,
    Emitter<AuthFormInteractionsState> emit,
  ) {
    emit(state.copyWith(isFieldFocused: event.isFocused));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthFormInteractionsState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onResetPasswordVisibility(
    ResetPasswordVisibilityEvent event,
    Emitter<AuthFormInteractionsState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: false));
  }
}
