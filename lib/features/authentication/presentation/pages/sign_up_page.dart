// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/widgets/sign_up_form_widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In Form')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              16.0,
            ), // Add padding for better layout
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}
