import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';

abstract class GameHistoryEvent {}

class SaveGameHistory extends GameHistoryEvent {
  final GameHistoryModel gameHistory;

  SaveGameHistory({required this.gameHistory});
}
