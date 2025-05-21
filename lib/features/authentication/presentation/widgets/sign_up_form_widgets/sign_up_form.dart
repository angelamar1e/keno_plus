// ignore_for_file: unused_import

import 'package:keno_plus/core/router/app_routes.dart';
import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/CTA_button.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/age_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/birthdate_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/email_address_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/loading_indicator.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/name_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/password_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/phone_number_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/username_field.dart';

/// Sign up form widget that handles user registration.
///
/// This widget creates a complete sign up form with all required user fields,
/// submit button, loading indicator, and navigation to login.
class SignUpForm extends StatelessWidget {
  // Dependencies
  final AuthenticationBloc authBloc;
  final AuthFormType formType;

  /// Creates a sign up form with the necessary dependencies.
  SignUpForm({super.key})
    : authBloc = sl<AuthenticationBloc>(),
      formType = AuthFormType.signUp;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final status = state.status;

        // Handle registration status
        if (status != null) {
          status.fold(
            // Handle failure cases
            (failure) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(failure.failure.toString())),
              ),
            },
            // Handle success case
            (newUser) => {
              authBloc.add(AuthenticationSucceeded(user: newUser)),
              // Navigate to home if sign up is successful
              context.goNamed(AppRoutes.home),
            },
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return KenoMainLayout(
            content: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      child: KenoFormDialogWidget(
                        // Header content
                        logo: AppImages.logo,
                        headerTitleText: AppStrings.welcomeTitle,
                        headerSubText: AppStrings.welcomeDesc,

                        // Form content
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Personal information fields
                            NameField(
                              labelText: AppStrings.firstNameLabel,
                              hintText: AppStrings.firstNameHint,
                              onChanged:
                                  (value) => context.read<SignUpBloc>().add(
                                    FirstNameChanged(value),
                                  ),
                              valueSelector: (_) => state.firstName.value,
                            ),
                            const VerticalSpacer(),
                            NameField(
                              labelText: AppStrings.lastNameLabel,
                              hintText: AppStrings.lastNameHint,
                              onChanged:
                                  (value) => context.read<SignUpBloc>().add(
                                    LastNameChanged(value),
                                  ),
                              valueSelector: (_) => state.lastName.value,
                            ),
                            const VerticalSpacer(),

                            // Demographic information
                            BirthdateField(),
                            const VerticalSpacer(),
                            AgeField(),
                            const VerticalSpacer(),

                            // Contact information
                            const PhoneNumberField(),
                            const VerticalSpacer(),
                            const EmailAddressField(),
                            const VerticalSpacer(),

                            // Account information
                            const UserNameField(),
                            const VerticalSpacer(),
                            const PasswordField(),
                            const VerticalSpacer(),

                            // Action buttons
                            CTAButton(formType),
                            LoadingIndicator(isSubmitting: state.isSubmitting),
                            const VerticalSpacer(),

                            // Secondary actions
                            KenoDesciptiveTextButton(
                              onPressed: () => context.goNamed(AppRoutes.login),
                              descriptiveText: AppStrings.alreadyHaveAcc,
                              buttonText: AppStrings.login,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
