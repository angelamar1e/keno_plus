part of 'sign_up_bloc.dart';

sealed class SignUpEvent {
  const SignUpEvent();
}

class CreatingUser extends SignUpEvent {
  final UserModel user;

  CreatingUser({required this.user});
}
