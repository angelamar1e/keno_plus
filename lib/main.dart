import 'core/values/app_imports.dart';
import 'package:keno_plus/core/router/router.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/features/authentication/domain/use_cases/create_user.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();

  // Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      BlocProvider(
        // global access to AuthenticationBloc
        create: (context) => AuthenticationBloc(createUser: sl<CreateUser>()),
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
