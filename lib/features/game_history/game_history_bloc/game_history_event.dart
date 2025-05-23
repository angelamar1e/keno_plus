import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';

abstract class GameHistoryEvent {}

class SaveGameHistory extends GameHistoryEvent {
  final Map<String, CardPayoutInfo> cardPayouts;
  final DateTime timestamp;
  final String gameMode;
  final double wager;

  SaveGameHistory({
    required this.cardPayouts,
    required this.timestamp,
    required this.gameMode,
    required this.wager,
  });
}
