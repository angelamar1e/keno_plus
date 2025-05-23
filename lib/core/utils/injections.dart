import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/authentication/auth_injections.dart';
import 'package:keno_plus/features/game_history/game_history_injections.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initAuthInjections();
  await initGameHistoryInjections();
  await initGameplayInjections();
}
