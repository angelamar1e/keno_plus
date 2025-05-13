import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/authentication/user_injection.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initAuthInjections();
}
