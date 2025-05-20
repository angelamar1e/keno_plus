class GameHistoryEntity {
  final int historyId;
  final String username;
  final String timestamp;
  final String gameMode;
  final String betsPicked;
  final String winningBets;
  final double wager;
  final double amountWon;
  final double amountLost;

  GameHistoryEntity({
    required this.historyId,
    required this.username,
    required this.timestamp,
    required this.gameMode,
    required this.betsPicked,
    required this.winningBets,
    required this.wager,
    required this.amountWon,
    required this.amountLost,
  });
}
