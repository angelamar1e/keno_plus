import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class UserNameField extends StatelessWidget {
  const UserNameField({super.key});

  final String fieldName = 'Username';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
              (value) => context.read<SignUpBloc>().add(UsernameChanged(value)),
          validator: (_) {
            String? error;

            if (state.isUsernameUnique) {
              state.username.value.fold(
                (fail) {
                  switch (fail) {
                    case Empty():
                      error = '$fieldName is required';
                      break;
                    case TooShort():
                      error = '$fieldName should be at least 3 characters';
                      break;
                    case TooLong():
                      error = '$fieldName should be at most 20 characters';
                      break;
                    case Invalid():
                      error =
                          'Invalid $fieldName, only letters, numbers, and underscores are allowed';
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
              error = '$fieldName already exists';
            }
            return error;
          },
          autovalidateMode:
              (state.showError
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled),
        );
      },
    );
  }
}
