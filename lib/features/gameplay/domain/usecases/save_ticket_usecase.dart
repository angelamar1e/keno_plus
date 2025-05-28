import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';
import 'package:keno_plus/features/gameplay/domain/repository/ticket_repository.dart';

class SaveTicketUsecase {
  final TicketRepository repository;

  SaveTicketUsecase(this.repository);

  Future<Either<Fail<String>, void>> call(TicketModel ticket) async {
    return await repository.insertTicket(ticket);
  }
}
