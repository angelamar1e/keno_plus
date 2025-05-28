import 'package:keno_plus/core/constants/classic_payout_table.dart';
import 'package:keno_plus/core/constants/mini_payout_table.dart';

double calculatePayout({
  required int numberOfSpots,
  required int numberOfCatches,
  required double wager,
  required bool isClassicMode,
}) {
  // Select the appropriate payout table
  final payoutTable = isClassicMode ? classicPayoutTable : miniPayoutTable;

  // Get the payout multiplier for the given spots and catches
  final spotPayouts = payoutTable[numberOfSpots];
  if (spotPayouts == null) {
    return 0;
  }

  final multiplier = spotPayouts[numberOfCatches] ?? 0;
  return wager * multiplier;
}
