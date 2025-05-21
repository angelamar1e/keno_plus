import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Age input field with validation for minimum age requirement.
///
/// This widget renders a read-only form field that:
/// - Displays the calculated age from the birthdate
/// - Validates the user is at least 18 years old
/// - Shows appropriate validation error messages
class AgeField extends StatelessWidget {
  /// Creates an age field widget
  AgeField({super.key});

  /// The display name for this field
  final String fieldText = 'Age';

  /// Text controller to display calculated age
  final ageController = TextEditingController();

  /// Focus node for the field
  final FocusNode ageFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        // Update displayed text from state
        state.age.value.fold(
          (fail) => {ageController.text = fail.failedValue ?? ''},
          (age) => {ageController.text = age.toString()},
        );

        return KenoFormField(
          // Field appearance
          controller: ageController,
          label: fieldText,
          keyboardType: TextInputType.none,

          // Field behavior
          isAge: true,
          autocorrect: false,
          readOnly: true,
          enabled: false,

          // Validation
          validator:
              (_) => state.age.value.fold(
                (fail) => switch (fail) {
                  Empty() => '*required',
                  Underage() =>
                    'You have to be at least 18 years old to register',
                  _ => null,
                },
                (success) => null,
              ),
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
        );
      },
    );
  }
}
