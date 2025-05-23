import 'package:keno_plus/features/game_history/domain/repositories/game_history_repository.dart';

class SaveGameHistoryUseCase {
  final GameHistoryRepository gameHistoryRepository;

  SaveGameHistoryUseCase(this.gameHistoryRepository);

  Future<void> call({
    required DateTime timestamp,
    required String gameMode,
    required double wager,
    required Map<String, dynamic> cardPayouts,
  }) async {
    await gameHistoryRepository.saveGameHistory(
      timestamp: timestamp,
      gameMode: gameMode,
      wager: wager,
      cardPayouts: cardPayouts,
    );
  }
}
