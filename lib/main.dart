import 'core/values/app_imports.dart';

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
      create: (context) => AuthenticationBloc(createUser: sl<CreateUser>()),
      child: MaterialApp.router(
        title: AppStrings.appName,
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
