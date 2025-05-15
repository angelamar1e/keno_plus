import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';

final sl = GetIt.instance;

initGameplayInjections() async {
  // Register GameConfigBloc
  sl.registerSingleton<GameConfigBloc>(GameConfigBloc());
}
