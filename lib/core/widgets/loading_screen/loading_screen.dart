import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger the CheckAuthenticationStatus event
    context.read<AuthenticationBloc>().add(CheckAuthenticationStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          // Navigate to the home page if authenticated
          context.goNamed(AppRoutes.home);
        } else if (state.isUnauthenticated) {
          // Navigate to the login page if not authenticated
          context.goNamed(AppRoutes.login);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // Display the loading screen while checking authentication status
          if (state.isCheckingAuthStatus) {
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
          }

          // Return an empty container if navigation is already handled
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
