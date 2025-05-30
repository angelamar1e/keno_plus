import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/game_history/domain/repositories/game_history_repository.dart';

class SaveGameHistoryUseCase {
  final GameHistoryRepository gameHistoryRepository;

  SaveGameHistoryUseCase(this.gameHistoryRepository);

  Future<Either<Fail, int>> call(GameHistoryModel gameHistory) async {
    return await gameHistoryRepository.saveGameHistory(gameHistory);
  }
}
