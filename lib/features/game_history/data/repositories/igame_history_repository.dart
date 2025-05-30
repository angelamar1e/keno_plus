import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/game_history/data/datasources/game_history_datasource.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/game_history/domain/repositories/game_history_repository.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';

class IGameHistoryRepository implements GameHistoryRepository {
  final GameHistoryDatasource datasource;

  IGameHistoryRepository(this.datasource);

  @override
  Future<Either<Fail, int>> saveGameHistory(
    GameHistoryModel gameHistory,
  ) async {
    return await datasource.insertGameHistory(gameHistory);
  }

  @override
  Future<Either<Fail, List<GameHistoryModel>>> getGameHistory(
    String username,
  ) async {
    return await datasource.getGameHistory(username);
  }

  @override
  Future<Either<Fail<String>, Tuple2<GameHistoryModel, List<TicketModel>>>>
  getGameHistoryAndTickets(int id) async {
    return await datasource.getGameHistoryAndTickets(id);
  }
}
