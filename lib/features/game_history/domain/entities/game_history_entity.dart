class GameHistoryEntity {
  final int? id;
  final String username;
  final String timestamp;
  final String gameMode;
  final double wager;

  GameHistoryEntity({
    required this.id,
    required this.username,
    required this.timestamp,
    required this.gameMode,
    required this.wager,
  });
}
