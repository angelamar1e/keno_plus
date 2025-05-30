import 'package:keno_plus/features/game_history/domain/entities/game_history_entity.dart';

class GameHistoryModel extends GameHistoryEntity {
  GameHistoryModel({
    required super.id,
    required super.username,
    required super.timestamp,
    required super.gameMode,
    required super.wager,
  });

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'timestamp': timestamp,
      'game_mode': gameMode,
      'wager': wager,
    };
  }

  // from map
  factory GameHistoryModel.fromMap(Map<String, dynamic> map) {
    return GameHistoryModel(
      id: map['id'] as int,
      username: map['username'] as String,
      timestamp: map['timestamp'] as String,
      gameMode: map['game_mode'] as String,
      wager: (map['wager'] as num).toDouble(),
    );
  }
}
