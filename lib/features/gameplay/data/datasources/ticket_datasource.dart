import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';

class TicketDataSource {
  final Database database;

  TicketDataSource(this.database);

  Future<Either<Fail, void>> createTicket(TicketModel ticket) async {
    try {
      await database.insert(
        'tickets',
        ticket.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Right(null);
    } catch (e) {
      return Left(Fail('Failed to create ticket: $e'));
    }
  }

  Future<Either<Fail, List<TicketModel>>> getTicketsByGameHistoryId(
    int gameHistoryId,
  ) async {
    try {
      final result = await database.query(
        'tickets',
        where: 'game_history_id = ?',
        whereArgs: [gameHistoryId],
      );

      if (result.isEmpty) {
        return Right([]);
      }

      final tickets =
          result.map((ticket) => TicketModel.fromMap(ticket)).toList();
      return Right(tickets);
    } catch (e) {
      return Left(Fail('Failed to fetch tickets: $e'));
    }
  }
}
