import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/gameplay/data/datasources/ticket_datasource.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';
import 'package:keno_plus/features/gameplay/domain/repository/ticket_repository.dart';

class ITicketRepository implements TicketRepository {
  final TicketDataSource ticketDataSource;

  ITicketRepository(this.ticketDataSource);

  @override
  Future<Either<Fail<String>, void>> insertTicket(TicketModel ticket) async {
    return await ticketDataSource.insertTicket(ticket);
  }

  @override
  Future<Either<Fail<String>, List<TicketModel>>> getTicketsByGameHistoryId(
    int gameHistoryId,
  ) async {
    return await ticketDataSource.getTicketsByGameHistoryId(gameHistoryId);
  }
}
