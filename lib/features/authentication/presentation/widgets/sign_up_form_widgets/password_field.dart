import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Password input field with validation and visibility toggle.
///
/// This widget renders a password input field that:
/// - Connects to the SignUpBloc for state management
/// - Validates password strength and requirements
/// - Includes toggle password visibility functionality
/// - Resets visibility when field is cleared
class PasswordField extends StatelessWidget {
  /// Creates a password field widget.
  const PasswordField({super.key});

  /// The display name for this field.
  final String fieldText = 'Password';
  final String hintText = 'Enter your pasword';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldText,
          hint: hintText,
          keyboardType: TextInputType.visiblePassword,

          // Field behavior
          autocorrect: false,
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,

          // Validation
          validator:
              (_) => state.password.value.fold(
                (fail) => switch (fail) {
                  Empty() => '$fieldText is required',
                  TooShort() => '$fieldText should be at least 8 characters',
                  Invalid() =>
                    '$fieldText must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
                  _ => null,
                },
                (success) => null,
              ),
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,

          // Event callbacks
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordChanged(value));
            if (value.isEmpty) {
              context.read<SignUpBloc>().add(ResetPasswordVisibilityEvent());
            }
          },
          onTogglePasswordVisibility: () {
            context.read<SignUpBloc>().add(TogglePasswordVisibilityEvent());
          },
        );
      },
    );
  }
}
