import 'core/values/app_imports.dart';

void main() {
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
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        fontFamily: AppFonts.inter,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
