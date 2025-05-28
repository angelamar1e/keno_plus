import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';

abstract class TicketRepository {
  Future<Either<Fail<String>, void>> insertTicket(TicketModel ticket);
  Future<Either<Fail<String>, List<TicketModel>>> getTicketsByGameHistoryId(
    int gameHistoryId,
  );
}
