import 'package:keno_plus/core/router/app_routes.dart';
import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/CTA_button.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/login_form_widgets/password_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/login_form_widgets/username_field.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/auth_form_widgets/loading_indicator.dart';
import 'package:keno_plus/features/wallet/presentation/bloc/wallet_bloc.dart';

/// Login form widget that handles user authentication.
///
/// This widget creates a complete login form with username and password fields,
/// submit button, loading indicator, and navigation to sign up.
class LogInForm extends StatelessWidget {
  // Dependencies
  final AuthenticationBloc authBloc;
  final WalletBloc walletBloc;
  final AuthFormType formType;

  /// Creates a login form with the necessary dependencies.
  LogInForm({super.key})
    : authBloc = sl<AuthenticationBloc>(),
      walletBloc = sl<WalletBloc>(),
      formType = AuthFormType.login;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInBloc, LogInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;

        // Handle authentication status
        if (status != null) {
          status.fold(
            // Handle failure cases
            (failure) => {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: switch (failure) {
                      UserDoesNotExist() => const Text('User does not exist'),
                      WrongPassword() => const Text('Incorrect password'),
                      _ => const Text('Authentication failed'),
                    },
                    duration: const Duration(seconds: 3),
                  ),
                ),
            },
            // Handle success case
            (user) => {
              // Dispatch event to update authentication state
              authBloc.add(AuthenticationSucceeded(user: user)),

              // Dispatch event to get the user's wallet
              walletBloc.add(GetBalance(user.username)),

              // Navigate to home if login is successful
              context.goNamed(AppRoutes.home),
            },
          );
        }
      },
      child: BlocBuilder<LogInBloc, LogInState>(
        builder: (context, state) {
          return Form(
            child: KenoFormDialogWidget(
              // Header content
              logo: AppImages.logo,
              headerTitleText: AppStrings.welcomeTitle,
              headerSubText: AppStrings.welcomeDesc,
              // Form fields and buttons
              content: Column(
                children: [
                  // Form fields
                  const UserNameField(),
                  const VerticalSpacer(),
                  const PasswordField(),
                  const VerticalSpacer(),

                  // Action buttons
                  CTAButton(formType),
                  const VerticalSpacer(),
                  LoadingIndicator(isSubmitting: state.isSubmitting),
                  const VerticalSpacer(),

                  // Secondary actions
                  KenoDesciptiveTextButton(
                    onPressed: () => context.goNamed(AppRoutes.signUp),
                    descriptiveText: AppStrings.dontHaveAcc,
                    buttonText: AppStrings.signUp,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
