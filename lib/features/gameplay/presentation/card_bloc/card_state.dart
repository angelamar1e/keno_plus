// ignore_for_file: public_member_api_docs, sort_constructors_first

class CardState {
  CardState({
    required this.largestNumber,
    required this.numberOfBets,
    required this.bets,
    required this.wager,
    required this.winningBets,
    required this.matchedBets,
  });

  final int largestNumber;
  final int numberOfBets;
  final List<int> bets;
  final int wager;
  final List<int> winningBets;
  final List<int> matchedBets;

  factory CardState.initial() {
    return CardState(
      bets: [],
      wager: 0,
      winningBets: [],
      numberOfBets: 1,
      matchedBets: [],
      largestNumber: 80,
    );
  }

  CardState copyWith({
    int? largestNumber,
    int? numberOfBets,
    List<int>? bets,
    int? wager,
    List<int>? winningBets,
    List<int>? matchedBets,
  }) {
    return CardState(
      largestNumber: largestNumber ?? this.largestNumber,
      numberOfBets: numberOfBets ?? this.numberOfBets,
      bets: bets ?? this.bets,
      wager: wager ?? this.wager,
      winningBets: winningBets ?? this.winningBets,
      matchedBets: matchedBets ?? this.matchedBets,
    );
  }
}
