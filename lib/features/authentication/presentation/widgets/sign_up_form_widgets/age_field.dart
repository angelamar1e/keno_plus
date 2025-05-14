import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class AgeField extends StatelessWidget {
  AgeField({super.key});

  final String fieldName = 'Age';
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        state.age.value.fold(
          (fail) => {ageController.text = fail.failedValue ?? ''},
          (age) => {ageController.text = age.toString()},
        );

        return TextFormField(
          controller: ageController,
          decoration: InputDecoration(
            labelText: fieldName,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
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
          autocorrect: false,
          readOnly: true,
          autovalidateMode:
              state.showErrors
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
        );
      },
    );
  }
}
