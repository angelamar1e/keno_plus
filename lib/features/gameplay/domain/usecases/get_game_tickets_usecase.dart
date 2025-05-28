import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';
import 'package:keno_plus/features/gameplay/domain/repository/ticket_repository.dart';

class GetGameTicketsUsecase {
  final TicketRepository repository;

  GetGameTicketsUsecase(this.repository);

  Future<Either<Fail<String>, List<TicketModel>>> call(
    int gameHistoryId,
  ) async {
    return await repository.getTicketsByGameHistoryId(gameHistoryId);
  }
}
