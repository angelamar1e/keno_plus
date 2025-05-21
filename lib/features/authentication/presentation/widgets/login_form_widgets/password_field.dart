import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';

/// Password input field with toggle visibility and validation.
///
/// This widget renders a password input field that:
/// - Connects to the LogInBloc for state management
/// - Provides validation feedback
/// - Includes toggle password visibility functionality
/// - Resets visibility when field is cleared
class PasswordField extends StatelessWidget {
  /// Creates a password field widget.
  const PasswordField({super.key});

  /// The display name for this field.
  final String fieldName = 'Password';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LogInState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldName,
          keyboardType: TextInputType.visiblePassword,

          // Field behavior
          autocorrect: false,
          isPassword: true,
          isPasswordVisible: state.isPasswordVisible,

          // Validation
          validator: (_) {
            return state.password.value.fold(
              (fail) => switch (fail) {
                Empty() => '$fieldName is required',
                _ => null,
              },
              (success) => null,
            );
          },
          autovalidateMode:
              state.showErrors == true
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,

          // Event callbacks
          onChanged: (value) {
            context.read<LogInBloc>().add(PasswordChanged(value));
            if (value.isEmpty) {
              context.read<LogInBloc>().add(ResetPasswordVisibilityEvent());
            }
          },
          onTogglePasswordVisibility: () {
            context.read<LogInBloc>().add(TogglePasswordVisibilityEvent());
          },
        );
      },
    );
  }
}
