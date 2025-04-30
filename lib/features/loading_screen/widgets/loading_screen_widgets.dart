import 'package:keno_plus/shared/app/app_imports.dart';

class LoadingScreenWidget extends StatefulWidget {
  const LoadingScreenWidget({super.key});

  @override
  State<LoadingScreenWidget> createState() => _LoadingScreenWidgetState();
}

class _LoadingScreenWidgetState extends State<LoadingScreenWidget> {
  bool _showProgressIndicator = false;

  @override
  void initState() {
    super.initState();
    // Delay showing the progress indicator
    Timer(const Duration(seconds: 1 /*3*/), () {
      if (mounted) {
        setState(() {
          _showProgressIndicator = true;
        });
      }
    });

    // Navigate to home screen after a delay
    Timer(const Duration(seconds: 1 /*5*/), () {
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
              showLogo(),
              SizedBox(height: 32.0),
              if (_showProgressIndicator) showLoading(),
            ],
          ),
        ],
      ),
    );
  }

  CircularProgressIndicator showLoading() {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }

  Flexible showLogo() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Image.asset(AppImages.logo),
      ),
    );
  }
}
