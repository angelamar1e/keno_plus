import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Name input field with validation.
///
/// This widget renders a name input field that:
/// - Connects to the SignUpBloc for state management
/// - Validates name format (length, valid characters)
/// - Can be used for both first and last name fields
/// - Provides appropriate validation feedback
class NameField extends StatelessWidget {
  // Field properties
  final String labelText;
  final String hintText;

  // Callbacks and state
  final Function(String) onChanged;
  final Either<ValueFailure, String> Function(SignUpState) valueSelector;

  /// Creates a name field widget.
  const NameField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.valueSelector,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return KenoFormField(
          // Field appearance
          label: labelText,
          hint: hintText,
          keyboardType: TextInputType.name,

          // Field behavior
          autocorrect: false,

          // Validation
          validator:
              (_) => valueSelector(state).fold(
                (fail) => switch (fail) {
                  Empty() => '$labelText is required',
                  TooShort() => '$labelText is too short',
                  TooLong() => '$labelText is too long',
                  Invalid() => 'Invalid $labelText',
                  _ => null,
                },
                (success) => null,
              ),
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,

          // Event callbacks
          onChanged: onChanged,
        );
      },
    );
  }
}
