import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/game_history/data/datasources/game_history_datasource.dart';
import 'package:keno_plus/features/game_history/data/repositories/igame_history_repository.dart';
import 'package:keno_plus/features/game_history/domain/repositories/game_history_repository.dart';
import 'package:keno_plus/features/game_history/domain/usecases/save_game_history_usecase.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_bloc.dart';

final sl = GetIt.instance;

initGameHistoryInjections() async {
  final database = await AppDatabase().database;

  sl.registerSingleton<GameHistoryDatasource>(GameHistoryDatasource(database));
  sl.registerSingleton<GameHistoryRepository>(IGameHistoryRepository(sl()));
  sl.registerSingleton<SaveGameHistoryUseCase>(SaveGameHistoryUseCase(sl()));
  sl.registerSingleton<GameHistoryBloc>(GameHistoryBloc(sl()));
}
