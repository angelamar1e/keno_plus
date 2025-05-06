import 'package:keno_plus/core/values/app_imports.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }
}

class ShowLogo extends StatelessWidget {
  final String logo;

  const ShowLogo({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Image.asset(logo),
      ),
    );
  }
}
