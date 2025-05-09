import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class EmailAddressField extends StatelessWidget {
  const EmailAddressField({super.key});

  final String fieldName = 'Email Address';

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
              (value) => context.read<SignUpBloc>().add(EmailChanged(value)),
          validator:
              (_) => state.email.value.fold(
                (fail) => switch (fail) {
                  Empty() => '$fieldName is required',
                  Invalid() => 'Invalid $fieldName',
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
