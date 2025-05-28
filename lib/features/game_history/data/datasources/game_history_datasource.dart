import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';

class GameHistoryDatasource {
  final Database database;

  GameHistoryDatasource(this.database);

  Future<Either<Fail, int>> insertGameHistory(
    GameHistoryModel gameHistory,
  ) async {
    try {
      final id = await database.insert(
        'game_history',
        gameHistory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Right(id);
    } catch (e) {
      return Left(Fail('Failed to insert game history: $e'));
    }
  }

  Future<Either<Fail, List<GameHistoryModel>>> getGameHistory(
    String username,
  ) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'game_history',
        where: 'username = ?',
        whereArgs: [username],
      );

      if (maps.isEmpty) {
        return Right([]);
      }

      final gameHistoryList =
          maps.map((map) => GameHistoryModel.fromMap(map)).toList();
      return Right(gameHistoryList);
    } catch (e) {
      return Left(Fail('Failed to fetch game history: $e'));
    }
  }

  Future<Either<Fail<String>, Tuple2<GameHistoryModel, List<TicketModel>>>>
  getGameHistoryAndTickets(int id) async {
    try {
      // join 2 tables: game_history and tickets
      final List<Map<String, dynamic>> maps = await database.rawQuery(
        '''
        SELECT gh.id as id, username, timestamp, game_mode, wager, t.id as ticket_id, winning_numbers, spots, catches, payout
        FROM game_history gh
        LEFT JOIN tickets t ON gh.id = t.game_history_id
        WHERE gh.id = ?
        ''',
        [id],
      );

      List<TicketModel> tickets = [];
      GameHistoryModel gameHistory = GameHistoryModel.fromMap(maps.first);

      for (final map in maps) {
        final ticket = TicketModel.fromMap(map);

        tickets.add(ticket);
      }

      return Right(Tuple2(gameHistory, tickets));
    } catch (e) {
      return Left(Fail('Failed to fetch game history and tickets: $e'));
    }
  }
}
