import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';

final sl = GetIt.instance;

initGameplayInjections() async {
  // Register GameConfigBloc
  sl.registerSingleton<GameConfigBloc>(GameConfigBloc());
  sl.registerSingleton<WagerBloc>(WagerBloc());
  sl.registerSingleton<PayoutBloc>(PayoutBloc());
}
