import 'package:keno_plus/core/values/app_imports.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showProgressIndicator = false;

  @override
  void initState() {
    super.initState();
    // Delay showing the progress indicator
    Timer(const Duration(seconds: 2 /*3*/), () {
      if (mounted) {
        setState(() {
          _showProgressIndicator = true;
        });
      }
    });

    // Navigate to home screen after a delay
    Timer(const Duration(seconds: 3 /*5*/), () {
      if (mounted) {
        context.goNamed(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradientBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShowLogo(logo: AppImages.logo),
              SizedBox(height: 32.0),
              if (_showProgressIndicator) ShowLoading(),
            ],
          ),
        ],
      ),
    );
  }
}
