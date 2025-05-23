class GameHistoryEntity {
  final int historyId;
  final String username;
  final String timestamp;
  final String gameMode;
  final String betsPicked;
  final String winningBets;
  final double wager;
  final double amount;
  final Result result;

  GameHistoryEntity({
    required this.historyId,
    required this.username,
    required this.timestamp,
    required this.gameMode,
    required this.betsPicked,
    required this.winningBets,
    required this.wager,
    required this.amount,
    required this.result,
  });
}

enum Result { lost, won }
