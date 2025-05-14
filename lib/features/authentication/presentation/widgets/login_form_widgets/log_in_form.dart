// ignore_for_file: unused_import

import 'dart:io';

import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/CTA_button.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/login_form_widgets/password_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/login_form_widgets/username_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/loading_indicator.dart';

class LogInForm extends StatelessWidget {
  LogInForm({super.key});

  final authBloc = sl<AuthenticationBloc>();
  final AuthFormType formType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<LogInBloc, LogInState>(
        listener: (context, state) {
          final status = state.status;

          // show error via a snackbar or navigate to home
          if (status != null) {
            status.fold(
              (failure) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: switch (failure) {
                      UserDoesNotExist() => Text('User does not exist'),
                      WrongPassword() => Text('Incorrect password'),
                      _ => Text(''),
                    },
                  ),
                ),
              },
              (user) => {
                authBloc.add(AuthenticationSucceeded(user: user)),

                // navigate to home if sign up is successful
                context.goNamed(AppRoutes.home),
              },
            );
          }
        },
        child: BlocBuilder<LogInBloc, LogInState>(
          builder: (context, state) {
            return SingleChildScrollView(
              reverse: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 30,
                          ),
                          child: UserNameField(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 30,
                          ),
                          child: PasswordField(),
                        ),
                        SizedBox(height: 30),
                        CTAButton(formType),
                        SizedBox(height: 15),
                        LoadingIndicator(isSubmitting: state.isSubmitting),

                        // go to sign up
                        TextButton(
                          onPressed: () {
                            context.goNamed(
                              AppRoutes.signUp,
                            ); // Navigate to the sign-up page
                          },
                          child: Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
