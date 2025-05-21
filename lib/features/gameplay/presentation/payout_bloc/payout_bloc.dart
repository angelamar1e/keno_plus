import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_event.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

class PayoutBloc extends Bloc<PayoutEvent, PayoutState> {
  // Mini Keno payout table (1-10 spots)
  static const Map<int, Map<int, double>> _miniPayoutTable = {
    1: {1: 4.25},
    2: {1: 0, 2: 12.0},
    3: {1: 0, 2: 2.0, 3: 30.0},
    4: {1: 0, 2: 1.0, 3: 4.0, 4: 100.0},
    5: {1: 0, 2: 0, 3: 2.0, 4: 15.0, 5: 300.0},
    6: {1: 0, 2: 0, 3: 1.0, 4: 5.0, 5: 50.0, 6: 1000.0},
    7: {1: 0, 2: 0, 3: 0, 4: 2.0, 5: 15.0, 6: 100.0, 7: 2000.0},
    8: {1: 0, 2: 0, 3: 0, 4: 1.0, 5: 5.0, 6: 50.0, 7: 300.0, 8: 5000.0},
    9: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 2.0,
      6: 15.0,
      7: 100.0,
      8: 1000.0,
      9: 10000.0,
    },
    10: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 100000.0,
    },
  };

  // Classic Keno payout table (1-15 spots)
  static const Map<int, Map<int, double>> _classicPayoutTable = {
    1: {1: 3.5},
    2: {1: 0, 2: 12.0},
    3: {1: 0, 2: 2.0, 3: 30.0},
    4: {1: 0, 2: 1.0, 3: 4.0, 4: 100.0},
    5: {1: 0, 2: 0, 3: 2.0, 4: 15.0, 5: 300.0},
    6: {1: 0, 2: 0, 3: 1.0, 4: 5.0, 5: 50.0, 6: 1000.0},
    7: {1: 0, 2: 0, 3: 0, 4: 2.0, 5: 15.0, 6: 100.0, 7: 2000.0},
    8: {1: 0, 2: 0, 3: 0, 4: 1.0, 5: 5.0, 6: 50.0, 7: 300.0, 8: 5000.0},
    9: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 2.0,
      6: 15.0,
      7: 100.0,
      8: 1000.0,
      9: 10000.0,
    },
    10: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 100000.0,
    },
    11: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 10000.0,
      11: 100000.0,
    },
    12: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 10000.0,
      11: 50000.0,
      12: 100000.0,
    },
    13: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 10000.0,
      11: 50000.0,
      12: 100000.0,
      13: 1000000.0,
    },
    14: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 10000.0,
      11: 50000.0,
      12: 100000.0,
      13: 500000.0,
      14: 1000000.0,
    },
    15: {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 5.0,
      7: 50.0,
      8: 300.0,
      9: 2000.0,
      10: 10000.0,
      11: 50000.0,
      12: 100000.0,
      13: 500000.0,
      14: 1000000.0,
      15: 10000000.0,
    },
  };

  PayoutBloc() : super(PayoutState.initial()) {
    on<CalculatePayouts>(_onCalculatePayouts);
    on<ResetPayouts>(_onResetPayouts);
  }

  double _calculatePayout({
    required int numberOfSpots,
    required int numberOfCatches,
    required double wager,
    required bool isClassicMode,
  }) {
    // Validate inputs
    if (numberOfSpots < 1 || numberOfCatches < 0 || wager <= 0) {
      return 0;
    }

    // Select the appropriate payout table
    final payoutTable = isClassicMode ? _classicPayoutTable : _miniPayoutTable;

    // Validate number of spots based on game mode
    if (isClassicMode && numberOfSpots > 15) {
      return 0;
    } else if (!isClassicMode && numberOfSpots > 10) {
      return 0;
    }

    // Get the payout multiplier for the given spots and catches
    final spotPayouts = payoutTable[numberOfSpots];
    if (spotPayouts == null) {
      return 0;
    }

    final multiplier = spotPayouts[numberOfCatches] ?? 0;
    return wager * multiplier;
  }

  void _onCalculatePayouts(CalculatePayouts event, Emitter<PayoutState> emit) {
    final updatedPayouts = <String, CardPayoutInfo>{};
    var totalAmountWon = 0.0;

    for (var i = 0; i < event.cardBlocInstances.length; i++) {
      final cardBloc = event.cardBlocInstances[i];
      final cardState = cardBloc.state;

      final spots = cardState.bets.length;
      final catches = cardState.matchedBets.length;

      final amountWon = _calculatePayout(
        numberOfSpots: spots,
        numberOfCatches: catches,
        wager: event.wager,
        isClassicMode: event.isClassicMode,
      );

      updatedPayouts['Card $i'] = CardPayoutInfo(
        spots: spots,
        catches: catches,
        amountWon: amountWon,
      );

      totalAmountWon += amountWon;
    }

    emit(
      PayoutState(cardPayouts: updatedPayouts, totalAmountWon: totalAmountWon),
    );
  }

  void _onResetPayouts(ResetPayouts event, Emitter<PayoutState> emit) {
    emit(PayoutState.initial());
  }
}
