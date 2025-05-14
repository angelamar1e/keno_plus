import 'package:keno_plus/core/validation/value_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class NameField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final Either<ValueFailure, String> Function(SignUpState) valueSelector;

  const NameField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.valueSelector,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          keyboardType: TextInputType.name,
          autocorrect: false,
          onChanged: onChanged,
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
        );
      },
    );
  }
}
