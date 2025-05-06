import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/screens/sign_up.dart';

final GoRouter router = GoRouter(
  initialLocation: '/${AppRoutes.loadingScreen}',
  routes: [
    GoRoute(
      path: '/${AppRoutes.loadingScreen}',
      name: AppRoutes.loadingScreen,
      builder: (context, state) => const LoadingScreen(),
    ),
    // Sign Up route
    GoRoute(
      path: '/${AppRoutes.signUp}',
      name: AppRoutes.signUp,
      builder: (context, state) => SignUpScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        int currentIndex = 0;

        switch (state.matchedLocation) {
          case '/${AppRoutes.home}':
            currentIndex = 1;
            break;
          case '/${AppRoutes.profile}':
            currentIndex = 2;
            break;
          default:
        }

        return Scaffold(
          body: MainLayout(content: child),
          bottomNavigationBar: KenoBottomNavBar(currentIndex: currentIndex),
        );
      },
      routes: [
        GoRoute(
          path: '/${AppRoutes.home}',
          name: AppRoutes.home,
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: '/${AppRoutes.profile}',
          name: AppRoutes.profile,
          builder: (context, state) => const Profile(),
        ),
      ],
    ),
  ],
);
