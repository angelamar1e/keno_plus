import 'package:get_it/get_it.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/data/datasources/ticket_datasource.dart';
import 'package:keno_plus/features/gameplay/data/repository/iticket_repository.dart';
import 'package:keno_plus/features/gameplay/domain/repository/ticket_repository.dart';
import 'package:keno_plus/features/gameplay/domain/usecases/get_game_tickets_usecase.dart';
import 'package:keno_plus/features/gameplay/domain/usecases/save_ticket_usecase.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';

final sl = GetIt.instance;

initGameplayInjections() async {
  final database = await AppDatabase().database;

  // Register GameConfigBloc
  sl.registerSingleton<GameConfigBloc>(GameConfigBloc());

  sl.registerSingleton<TicketDataSource>(TicketDataSource(database));
  sl.registerSingleton<TicketRepository>(ITicketRepository(sl()));
  sl.registerSingleton<SaveTicketUsecase>(SaveTicketUsecase(sl()));
  sl.registerSingleton<GetGameTicketsUsecase>(GetGameTicketsUsecase(sl()));

  sl.registerSingleton<WagerBloc>(WagerBloc());
}
