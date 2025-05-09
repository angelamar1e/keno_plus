// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/authentication/data/models/age.dart';
import 'package:keno_plus/features/authentication/data/models/birthdate.dart';
import 'package:keno_plus/features/authentication/data/models/email_address.dart';
import 'package:keno_plus/features/authentication/data/models/name.dart';
import 'package:keno_plus/features/authentication/data/models/password.dart';
import 'package:keno_plus/features/authentication/data/models/phone_number.dart';

import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/data/models/username.dart';
import 'package:keno_plus/features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:keno_plus/features/authentication/domain/usecases/get_users_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CreateUser createUser;
  final GetUsers getUsers;

  SignUpBloc({required this.createUser, required this.getUsers})
    : super(SignUpState.initial()) {
    on<CreatingUser>(_onCreatingUser);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdateChanged>(_onBirthdateChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstName: Name(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastName: Name(event.lastName)));
  }

  void _onBirthdateChanged(BirthdateChanged event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        birthdate: Birthdate(event.birthdate),
        age: Age(event.birthdate),
        showError: true,
      ),
    );
  }

  void _onUsernameChanged(
    UsernameChanged event,
    Emitter<SignUpState> emit,
  ) async {
    final existingUsernames = await getUsers();
    final isUnique = !existingUsernames.contains(event.username);

    emit(
      state.copyWith(
        isUsernameUnique: isUnique,
        username: Username(event.username),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: Password(event.password)));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: EmailAddress(event.email)));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(phoneNumber: PhoneNumber(event.phoneNumber)));
  }

  void _onCreatingUser(CreatingUser event, Emitter<SignUpState> emit) async {
    final isFirstNameValid = state.firstName.value.isRight();
    final isLastNameValid = state.lastName.value.isRight();
    final isAgeValid = state.age.value.isRight();
    final isPhoneNumberValid = state.phoneNumber.value.isRight();
    final isEmailValid = state.email.value.isRight();
    final isUsernameValid =
        state.username.value.isRight() && state.isUsernameUnique;
    final isPasswordValid = state.password.value.isRight();

    // Extract valid values
    final firstName = state.firstName.value.getOrElse(() => '');
    final lastName = state.lastName.value.getOrElse(() => '');
    final birthdate = state.birthdate.value ?? '';
    final age = state.age.value.getOrElse(() => 0) ?? 0;
    final username = state.username.value.getOrElse(() => '');
    final password = state.password.value.getOrElse(() => '');
    final phoneNumber = state.phoneNumber.value.getOrElse(() => '');
    final email = state.email.value.getOrElse(() => '');

    // Create a UserModel
    final user = UserModel(
      firstName: firstName,
      lastName: lastName,
      username: username,
      password: password,
      phoneNumber: phoneNumber,
      email: email,
      birthdate: birthdate,
      age: age,
    );

    if (isFirstNameValid &&
        isLastNameValid &&
        isAgeValid &&
        isPhoneNumberValid &&
        isEmailValid &&
        isUsernameValid &&
        isPasswordValid) {
      emit(state.copyWith(isSubmitting: true, status: null));

      await Future.delayed(const Duration(seconds: 1));
    }

    final result = await createUser(user);
    emit(state.copyWith(isSubmitting: false, status: result));
  }
}
