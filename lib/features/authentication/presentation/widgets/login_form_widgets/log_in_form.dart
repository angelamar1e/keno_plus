// ignore_for_file: unused_import

import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/CTA_button.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/age_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/birthdate_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/email_address_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/loading_indicator.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/name_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/password_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/phone_number_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/username_field.dart';

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

          if (status != null) {
            status.fold(
              (failure) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(failure.failure.toString())),
                ),
              },
              (newUser) => {
                authBloc.add(AuthenticationSucceeded(user: newUser)),

                // navigate to home if sign up is successful
                context.goNamed(AppRoutes.home),
              },
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
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
                          child: UserNameField(formType),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 30,
                          ),
                          child: PasswordField(formType),
                        ),
                        SizedBox(height: 30),
                        CTAButton(formType),
                        SizedBox(height: 15),
                        LoadingIndicator(),
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
