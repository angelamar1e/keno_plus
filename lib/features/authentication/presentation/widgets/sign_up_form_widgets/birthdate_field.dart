import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

Future<DateTime?> _showDatePicker(BuildContext context) async {
  final DateTime? datePicked = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  return datePicked;
}

class BirthdateField extends StatelessWidget {
  BirthdateField({super.key});

  final String fieldName = 'Birthday';
  final birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        birthdayController.text = state.birthdate.value ?? '';
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: birthdayController,
                decoration: InputDecoration(
                  labelText: fieldName,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                autocorrect: false,
                readOnly: true,
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
