import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Username input field with validation.
///
/// This widget renders a username input field that:
/// - Connects to the SignUpBloc for state management
/// - Validates username format and uniqueness
/// - Provides appropriate validation feedback
class UserNameField extends StatelessWidget {
  /// Creates a username field widget.
  const UserNameField({super.key});

  /// The display name for this field.
  final String fieldText = 'Username';
  final String hintText = 'Enter your username';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldText,
          hint: hintText,
          keyboardType: TextInputType.text,

          // Field behavior
          autocorrect: false,

          // Validation
          validator: (_) {
            String? error;

            if (state.isUsernameUnique) {
              state.username.value.fold(
                (fail) {
                  switch (fail) {
                    case Empty():
                      error = '$fieldText is required';
                      break;
                    case TooShort():
                      error = '$fieldText should be at least 3 characters';
                      break;
                    case TooLong():
                      error = '$fieldText should be at most 20 characters';
                      break;
                    case Invalid():
                      error =
                          'Invalid $fieldText, only letters, numbers, and underscores are allowed';
                      break;
                    default:
                      error = null;
                  }
                },
                (success) {
                  error = null; // No error if validation succeeds
                },
              );
            } else {
              error = '$fieldText already exists';
            }
            return error;
          },
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,

          // Event callbacks
          onChanged:
              (value) => context.read<SignUpBloc>().add(UsernameChanged(value)),
        );
      },
    );
  }
}
