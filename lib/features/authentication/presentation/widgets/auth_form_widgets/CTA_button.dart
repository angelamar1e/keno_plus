import 'package:keno_plus/core/utils/auth_form_type.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class CTAButton extends StatelessWidget {
  const CTAButton(this.formType, {super.key});

  final AuthFormType formType;
  @override
  Widget build(BuildContext context) {
    Function()? onPressed;
    String buttonText;

    switch (formType) {
      case AuthFormType.signUp:
        onPressed = () => context.read<SignUpBloc>().add(CreatingUser());
        buttonText = AppStrings.register;
        break;
      case AuthFormType.login:
        onPressed = () => context.read<LogInBloc>().add(LoggingIn());
        buttonText = AppStrings.login;
        break;
    }
    return KenoButton(text: buttonText, hasBorder: true, onPressed: onPressed);
  }
}
