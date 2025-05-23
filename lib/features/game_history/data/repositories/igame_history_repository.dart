import 'package:keno_plus/features/game_history/data/datasources/game_history_datasource.dart';
import 'package:keno_plus/features/game_history/domain/repositories/game_history_repository.dart';

class IGameHistoryRepository implements GameHistoryRepository {
  final GameHistoryDatasource datasource;

  IGameHistoryRepository(this.datasource);

  @override
  Future<void> saveGameHistory({
    required DateTime timestamp,
    required String gameMode,
    required double wager,
    required Map<String, dynamic> cardPayouts,
  }) async {
    await datasource.insertGameHistory(
      timestamp: timestamp,
      gameMode: gameMode,
      wager: wager,
      cardPayouts: cardPayouts,
    );
  }
}
