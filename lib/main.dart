import 'package:keno_plus/core/router/router.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

import 'core/values/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the dependency injection
  await initInjections();

  // Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      BlocProvider(
        create: (context) => sl<AuthenticationBloc>(),
        child: const KenoPlus(),
      ),
    );
  });
}

class KenoPlus extends StatelessWidget {
  const KenoPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
