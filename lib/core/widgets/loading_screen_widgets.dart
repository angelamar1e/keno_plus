import 'package:keno_plus/core/values/app_imports.dart';

class KenoShowLoading extends StatelessWidget {
  const KenoShowLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
    );
  }
}

class KenoShowLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final String logo;

  const KenoShowLogo({super.key, required this.logo, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width, child: Image.asset(logo));
  }
}
