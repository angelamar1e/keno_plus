import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Phone number input field with validation.
///
/// This widget renders a phone number input field that:
/// - Connects to the SignUpBloc for state management
/// - Validates phone number format (starting with 09 and 11 digits)
/// - Provides appropriate validation feedback
class PhoneNumberField extends StatelessWidget {
  /// Creates a phone number field widget.
  const PhoneNumberField({super.key});

  /// The display name for this field.
  final String fieldText = 'Phone Number';
    final String hintText = 'Enter your number';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: fieldText,
          hint: hintText,
          keyboardType: TextInputType.phone,

          // Field behavior
          autocorrect: false,

          // Validation
          validator:
              (_) => state.phoneNumber.value.fold(
                (fail) => switch (fail) {
                  Empty() => '$fieldText is required',
                  Invalid() =>
                    '$fieldText should start with 09 and be 11 digits long',
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
              (value) =>
                  context.read<SignUpBloc>().add(PhoneNumberChanged(value)),
        );
      },
    );
  }
}
