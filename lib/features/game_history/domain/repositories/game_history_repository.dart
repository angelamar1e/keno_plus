abstract class GameHistoryRepository {
  Future<void> saveGameHistory({
    required DateTime timestamp,
    required String gameMode,
    required double wager,
    required Map<String, dynamic> cardPayouts,
  });
}
