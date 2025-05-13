import 'core/values/app_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/router/router.dart';
import 'package:keno_plus/core/utils/injections.dart';
import 'package:keno_plus/features/authentication/domain/use_cases/create_user.dart';
import 'package:keno_plus/features/authentication/presentation/bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // global access to AuthenticationBloc
      create: (context) => AuthenticationBloc(createUser: sl<CreateUser>()),
      child: MaterialApp.router(
        routerConfig: router, // Use the GoRouter configuration
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
