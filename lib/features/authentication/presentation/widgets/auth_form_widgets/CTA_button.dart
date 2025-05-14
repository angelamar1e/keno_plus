// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class CTAButton extends StatelessWidget {
  const CTAButton(this.formType, {super.key});

  final AuthFormType formType;
  @override
  Widget build(BuildContext context) {
    Function()? onPressed;
    String buttonText;

    switch (formType) {
      case AuthFormType.signUp:
        onPressed = () => context.read<SignUpBloc>().add(CreatingUser());
        buttonText = 'Sign Up';
        break;
      case AuthFormType.login:
        onPressed = () => context.read<LogInBloc>().add(LoggingIn());
        buttonText = 'Login';
        break;
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonText, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
