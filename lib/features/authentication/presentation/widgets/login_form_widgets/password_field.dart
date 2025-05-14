import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  final String fieldName = 'Password';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LogInState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: fieldName,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          autocorrect: false,
          onChanged:
              (value) => context.read<LogInBloc>().add(PasswordChanged(value)),
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
        );
      },
    );
  }
}
