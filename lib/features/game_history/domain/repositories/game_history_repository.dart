import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';

abstract class GameHistoryRepository {
  Future<Either<Fail, int>> saveGameHistory(GameHistoryModel gameHistory);
  Future<Either<Fail, List<GameHistoryModel>>> getGameHistory(String username);
  Future<Either<Fail<String>, Tuple2<GameHistoryModel, List<TicketModel>>>>
  getGameHistoryAndTickets(int id);
}
