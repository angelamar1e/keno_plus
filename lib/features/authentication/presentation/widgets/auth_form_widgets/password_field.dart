import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(this.formType, {super.key});

  final String fieldName = 'Password';
  final AuthFormType formType;

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
              (value) => context.read<SignUpBloc>().add(PasswordChanged(value)),
          validator:
              (_) => state.password.value.fold(
                (fail) => switch (fail) {
                  Empty() => '$fieldName is required',
                  TooShort() when formType == AuthFormType.signUp =>
                    '$fieldName should be at least 8 characters',
                  Invalid() when formType == AuthFormType.signUp =>
                    '$fieldName must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
                  _ => null,
                },
                (success) => null,
              ),
          autovalidateMode: AutovalidateMode.onUnfocus,
        );
      },
    );
  }
}
