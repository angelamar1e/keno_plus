// ignore_for_file: public_member_api_docs, sort_constructors_first
class CardState {
  CardState({
    required this.numberOfBets,
    required this.bets,
    required this.wager,
    required this.winningBets,
  });

  final int numberOfBets;
  final List<int> bets;
  final int wager;
  final List<int> winningBets;

  factory CardState.initial() {
    return CardState(bets: [], wager: 0, winningBets: [], numberOfBets: 0);
  }

  CardState copyWith({
    int? numberOfBets,
    List<int>? bets,
    int? wager,
    List<int>? winningBets,
  }) {
    return CardState(
      numberOfBets: numberOfBets ?? this.numberOfBets,
      bets: bets ?? this.bets,
      wager: wager ?? this.wager,
      winningBets: winningBets ?? this.winningBets,
    );
  }
}
