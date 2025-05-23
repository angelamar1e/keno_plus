import 'package:keno_plus/features/game_history/domain/entities/game_history_entity.dart';

class GameHistoryModel extends GameHistoryEntity {
  GameHistoryModel({
    required super.historyId,
    required super.username,
    required super.timestamp,
    required super.gameMode,
    required super.betsPicked,
    required super.winningBets,
    required super.wager,
    required super.amount,
    required super.result,
  });
}
