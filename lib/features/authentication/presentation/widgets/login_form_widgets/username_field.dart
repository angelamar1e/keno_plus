import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';

/// Username input field with validation.
///
/// This widget renders a username input field that:
/// - Connects to the LogInBloc for state management
/// - Provides validation feedback
/// - Uses appropriate keyboard type for username input
class UserNameField extends StatelessWidget {
  /// Creates a username field widget.
  const UserNameField({super.key});

  /// The display name for this field.
  final String fieldName = 'Username';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LogInState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldName,
          keyboardType: TextInputType.emailAddress,

          // Field behavior
          autocorrect: false,

          // Validation
          validator: (_) {
            return state.username.value.fold(
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
          onChanged:
              (value) => context.read<LogInBloc>().add(UsernameChanged(value)),
        );
      },
    );
  }
}
