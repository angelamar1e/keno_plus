class CardPayoutInfo {
  final int spots;
  final int catches;
  final double amountWon;
  final List<int> winningNumbers;

  const CardPayoutInfo({
    required this.spots,
    required this.catches,
    required this.amountWon,
    required this.winningNumbers,
  });
}

class PayoutState {
  final Map<String, CardPayoutInfo>? cardPayouts;
  final double totalAmountWon;
  final bool isCalculating;
  final String? error;

  const PayoutState({
    this.cardPayouts,
    required this.totalAmountWon,
    required this.isCalculating,
    this.error,
  });

  factory PayoutState.initial() => const PayoutState(
    cardPayouts: null,
    totalAmountWon: 0,
    isCalculating: false,
  );

  PayoutState copyWith({
    Map<String, CardPayoutInfo>? cardPayouts,
    double? totalAmountWon,
    bool? isCalculating,
    String? error,
  }) {
    return PayoutState(
      cardPayouts: cardPayouts ?? this.cardPayouts,
      totalAmountWon: totalAmountWon ?? this.totalAmountWon,
      isCalculating: isCalculating ?? this.isCalculating,
      error: error,
    );
  }

  bool get hasPayouts => cardPayouts != null && cardPayouts!.isNotEmpty;
}
