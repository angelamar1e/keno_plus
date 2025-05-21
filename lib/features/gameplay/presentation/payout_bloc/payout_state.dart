class CardPayoutInfo {
  final int spots;
  final int catches;
  final double amountWon;

  const CardPayoutInfo({
    required this.spots,
    required this.catches,
    required this.amountWon,
  });
}

class PayoutState {
  final Map<String, CardPayoutInfo> cardPayouts;
  final double totalAmountWon;

  const PayoutState({required this.cardPayouts, required this.totalAmountWon});

  factory PayoutState.initial() =>
      const PayoutState(cardPayouts: {}, totalAmountWon: 0);

  PayoutState copyWith({
    Map<String, CardPayoutInfo>? cardPayouts,
    double? totalAmountWon,
  }) {
    return PayoutState(
      cardPayouts: cardPayouts ?? this.cardPayouts,
      totalAmountWon: totalAmountWon ?? this.totalAmountWon,
    );
  }
}
