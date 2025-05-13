import 'package:keno_plus/core/values/app_imports.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser createUser;
  AuthenticationBloc({required this.createUser})
    : super(AuthenticationState()) {
    on<CreatingUser>(_onCreatingUser);

    on<SwitchToLoginEvent>(_onSwitchToLogin);
    on<SwitchToSignupEvent>(_onSwitchToSignup);
    on<UpdateFirstNameEvent>(_onUpdateFirstName);
    on<UpdateLastNameEvent>(_onUpdateLastName);
    on<UpdateBirthDateEvent>(_onUpdateBirthDate);
    on<UpdateAgeEvent>(_onUpdateAge);
    on<UpdateEmailEvent>(_onUpdateEmail);
    on<UpdateUserNameEvent>(_onUpdateUserName);
    on<UpdateUserEmailEvent>(_onUpdateUserEmail);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<UpdateFieldFocusEvent>(_onUpdateFieldFocus);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ResetPasswordVisibilityEvent>(_onResetPasswordVisibility);
  }

  void _onCreatingUser(
    CreatingUser event,
    Emitter<AuthenticationState> emit,
  ) async {
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

  void _onUpdateFirstName(
    UpdateFirstNameEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onUpdateLastName(
    UpdateLastNameEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onUpdateBirthDate(
    UpdateBirthDateEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(birthDate: event.birthDate));
  }

  void _onUpdateAge(UpdateAgeEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(age: event.age));
  }

  void _onUpdateEmail(
    UpdateEmailEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onUpdateUserName(
    UpdateUserNameEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(userName: event.userName));
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

  void _onUpdateFieldFocus(
    UpdateFieldFocusEvent event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(isFieldFocused: event.isFocused));
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
