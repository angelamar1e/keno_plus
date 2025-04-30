import 'package:keno_plus/shared/app/app_imports.dart';

final GoRouter router = GoRouter(
  initialLocation: '/$AppRoutes.loadingScreen',
  routes: [
    GoRoute(
      path: '/$AppRoutes.loadingScreen',
      name: AppRoutes.loadingScreen,
      builder: (context, state) => const LoadingScreen(),
    ),
    GoRoute(
      path: '/$AppRoutes.home',
      name: AppRoutes.home,
      builder: (context, state) => const Home(),
    ),
  ],
);
