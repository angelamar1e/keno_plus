import 'package:keno_plus/core/values/app_imports.dart';

class GameHistoryDatasource {
  final Database database;

  GameHistoryDatasource(this.database);

  Future<void> insertGameHistory({
    required DateTime timestamp,
    required String gameMode,
    required double wager,
    required Map<String, dynamic> cardPayouts,
  }) async {
    await database.insert('game_history', {
      'timestamp': timestamp.toIso8601String(),
      'game_mode': gameMode,
      'wager': wager,
      'card_payouts': jsonEncode(cardPayouts),
    });
  }
}
