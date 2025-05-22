import 'package:keno_plus/core/router/app_routes.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:keno_plus/features/authentication/domain/usecases/get_by_username_usecase.dart';
import 'package:keno_plus/features/authentication/domain/usecases/get_users_usecase.dart';
import 'package:keno_plus/features/authentication/presentation/login_bloc/log_in_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/pages/log_in_page.dart';
import 'package:keno_plus/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/pages/gameplay_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/${AppRoutes.loadingScreen}',
  routes: [
    GoRoute(
      path: '/${AppRoutes.loadingScreen}',
      name: AppRoutes.loadingScreen,
      builder: (context, state) => const LoadingScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return KenoMainLayout(content: child);
      },
      routes: [
        GoRoute(
          path: '/${AppRoutes.login}',
          name: AppRoutes.login,
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) =>
                      LogInBloc(getUserByUsername: sl<GetUserByUsername>()),
              child: LogInPage(),
            );
          },
        ),

        GoRoute(
          path: '/${AppRoutes.signUp}',
          name: AppRoutes.signUp,
          builder: (context, state) {
            return BlocProvider(
              create:
                  (context) => SignUpBloc(
                    createUser: sl<CreateUser>(),
                    getUsers: sl<GetUsers>(),
                  ),
              child: SignUpPage(),
            );
          },
        ),
      ],
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
          body: KenoMainLayout(content: child),
          bottomNavigationBar: KenoBottomNavBar(currentIndex: currentIndex),
        );
      },
      routes: [
        GoRoute(
          path: '/${AppRoutes.home}',
          name: AppRoutes.home,
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<GameConfigBloc>(),
                child: const GameplayPage(),
              ),
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
