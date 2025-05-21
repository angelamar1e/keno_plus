import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_event.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';

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
    2: {1: 1, 2: 10.0},
    3: {1: 0, 2: 2.0, 3: 50.0},
    4: {1: 0, 2: 1.5, 3: 10.0, 4: 80.0},
    5: {1: 0, 2: 1.0, 3: 3.0, 4: 30.0, 5: 150.0},
    6: {1: 0, 2: 0, 3: 2.0, 4: 15.0, 5: 60.0, 6: 500.0},
    7: {0: 1, 1: 0, 2: 0, 3: 2, 4: 4.0, 5: 20.0, 6: 80.0, 7: 1000.0},
    8: {0: 1, 1: 0, 2: 0, 3: 0, 4: 5.0, 5: 15.0, 6: 50.0, 7: 200.0, 8: 2000.0},
    9: {
      0: 2,
      1: 0,
      2: 0,
      3: 0,
      4: 2.0,
      5: 10.0,
      6: 25.0,
      7: 125.0,
      8: 1000.0,
      9: 5000.0,
    },
    10: {
      0: 2.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 5.0,
      6: 30.0,
      7: 100.0,
      8: 300.0,
      9: 2000.0,
      10: 100000.0,
    },
    11: {
      0: 5.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 3.0,
      6: 10.0,
      7: 50.0,
      8: 200.0,
      9: 1200.0,
      10: 8500.0,
      11: 45000.0,
    },
    12: {
      0: 5.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 1.0,
      6: 7.0,
      7: 30.0,
      8: 150.0,
      9: 800.0,
      10: 5000.0,
      11: 12000.0,
      12: 55000.0,
    },
    13: {
      0: 7.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0.0,
      6: 5.0,
      7: 15.0,
      8: 100.0,
      9: 400.0,
      10: 2500.0,
      11: 10000.0,
      12: 35000.0,
      13: 170000.0,
    },
    14: {
      0: 10.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0.0,
      6: 2.50,
      7: 7.50,
      8: 50.0,
      9: 250.0,
      10: 1250.0,
      11: 7500.0,
      12: 20000.0,
      13: 95000.0,
      14: 380000.0,
    },
    15: {
      0: 15.0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0.0,
      6: 1.50,
      7: 5.0,
      8: 15.0,
      9: 120.0,
      10: 1000.0,
      11: 4500.0,
      12: 12000.0,
      13: 45000.0,
      14: 200000.0,
      15: 500000.0,
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
    final Map<String, CardPayoutInfo> updatedPayouts = {};
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

      updatedPayouts['Card ${i + 1}'] = CardPayoutInfo(
        spots: spots,
        catches: catches,
        amountWon: amountWon,
        winningNumbers: cardState.winningBets,
      );

      totalAmountWon += amountWon;
    }

    emit(
      PayoutState(
        cardPayouts: updatedPayouts,
        totalAmountWon: totalAmountWon,
        isCalculating: false,
      ),
    );
  }

  void _onResetPayouts(ResetPayouts event, Emitter<PayoutState> emit) {
    emit(PayoutState.initial());
  }
}
