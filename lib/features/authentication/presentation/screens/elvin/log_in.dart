import 'package:keno_plus/core/values/app_imports.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: const KenoLoginWidget(),
    );
  }
}
