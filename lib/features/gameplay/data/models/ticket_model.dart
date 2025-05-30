import 'package:keno_plus/features/gameplay/domain/entities/ticket_entity.dart';

class TicketModel extends TicketEntity {
  TicketModel({
    required super.id,
    required super.gameHistoryId,
    required super.winningNumbers,
    required super.spots,
    required super.catches,
    required super.payout,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game_history_id': gameHistoryId,
      'winning_numbers': winningNumbers,
      'spots': spots,
      'catches': catches,
      'payout': payout,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] as int,
      gameHistoryId: map['game_history_id'] as int,
      winningNumbers: map['winning_numbers'] as String,
      spots: map['spots'] as String,
      catches: map['catches'] as String,
      payout: (map['payout'] as num).toDouble(),
    );
  }
}
