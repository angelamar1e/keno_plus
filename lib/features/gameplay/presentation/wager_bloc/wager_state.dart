class WagerState {
  final double wager;
  static const double minWager = 20.0;
  static const double maxWager = 500.0;

  const WagerState({required this.wager});

  factory WagerState.initial() => const WagerState(wager: minWager);

  WagerState copyWith({double? wager}) {
    return WagerState(
      wager: wager ?? this.wager,
    );
  }
} 