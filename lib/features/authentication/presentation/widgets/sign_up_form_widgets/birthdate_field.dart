import 'package:keno_plus/core/themes/app_theme.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

/// Shows a styled date picker dialog and returns the selected date
Future<DateTime?> _showDatePicker(BuildContext context) async {
  return showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return AppTheme.themeDatePicker(context, child);
    },
  );
}

/// Birthday input field with date picker functionality
///
/// This widget renders a read-only form field that:
/// - Opens a date picker when tapped
/// - Formats and displays the selected date
/// - Updates the sign-up form state with the selected date
class BirthdateField extends StatelessWidget {
  /// Creates a birthdate field widget
  BirthdateField({super.key});

  /// The display name for this field
  final String fieldText = 'Birthday';
  final String hintText = 'Choose you birthdate';

  /// Text controller to display selected date
  final birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        // Update displayed text from state
        birthdayController.text = state.birthdate.value ?? '';

        return Row(
          children: [
            Expanded(
              child: KenoFormField(
                // Field appearance
                controller: birthdayController,
                label: fieldText,
                hint: hintText,

                // Field behavior
                isBirthdate: true,
                autocorrect: false,
                readOnly: true,

                // Event callbacks
                onTap:
                    () => _showDatePicker(context).then(
                      (pickedDate) => {
                        if (context.mounted)
                          {
                            context.read<SignUpBloc>().add(
                              BirthdateChanged(pickedDate),
                            ),
                          },
                      },
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
