import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the AuthenticationBloc to check the authentication status
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        Future.delayed(const Duration(seconds: 2), () {
          if (state.isAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed(AppRoutes.home);
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed(AppRoutes.signUp);
            });
          }
        });
        return Scaffold(
          body: Stack(
            children: [
              GradientBackground(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ShowLogo(logo: AppImages.logo),
                  const SizedBox(height: 32.0),
                  const CircularProgressIndicator(), // Show a loading indicator
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
