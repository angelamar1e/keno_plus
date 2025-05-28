class TicketEntity {
  final int? id;
  final int? gameHistoryId;
  final String winningNumbers;
  final String spots;
  final String catches;
  final double payout;

  TicketEntity({
    required this.id,
    required this.gameHistoryId,
    required this.winningNumbers,
    required this.spots,
    required this.catches,
    required this.payout,
  });
}
