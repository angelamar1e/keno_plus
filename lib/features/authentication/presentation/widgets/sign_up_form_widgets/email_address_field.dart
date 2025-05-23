import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Email address input field with validation.
///
/// This widget renders an email input field that:
/// - Connects to the SignUpBloc for state management
/// - Validates email format
/// - Provides appropriate validation feedback
class EmailAddressField extends StatelessWidget {
  /// Creates an email address field widget.
  const EmailAddressField({super.key});

  /// The display name for this field.
  final String fieldText = 'Email Address';
  final String hintText = 'Enter your email';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldText,
          hint: hintText,
          keyboardType: TextInputType.emailAddress,

          // Field behavior
          autocorrect: false,

          // Validation
          validator:
              (_) => state.email.value.fold(
                (fail) => switch (fail) {
                  Empty() => '$fieldText is required',
                  Invalid() => 'Invalid $fieldText',
                  _ => null,
                },
                (success) => null,
              ),
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,

          // Event callbacks
          onChanged:
              (value) => context.read<SignUpBloc>().add(EmailChanged(value)),
        );
      },
    );
  }
}
