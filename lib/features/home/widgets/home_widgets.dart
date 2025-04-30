import 'package:keno_plus/shared/app/app_imports.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(AppImages.menuBackground, fit: BoxFit.cover),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.primary.withAlpha(127),
          ),
        ],
      ),
    );
  }
}
