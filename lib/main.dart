import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

import 'core/values/app_imports.dart';
import 'package:keno_plus/core/router/router.dart';
import 'package:keno_plus/core/utils/injections.dart';

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
        // global access to AuthenticationBloc
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
    return MaterialApp.router(routerConfig: router);
  }
}
