// ignore_for_file: public_member_api_docs, sort_constructors_first

class TicketState {
  TicketState({
    required this.largestNumber,
    required this.numberOfSpots,
    required this.spots,
    required this.wager,
    required this.winningSpots,
    required this.catches,
    required this.payout,
    required this.isCalculating,
  });

  final int largestNumber;
  final int numberOfSpots;
  final List<int> spots;
  final int wager;
  final List<int> winningSpots;
  final List<int> catches;
  final double? payout;
  final bool isCalculating;

  factory TicketState.initial() {
    return TicketState(
      spots: [],
      wager: 0,
      winningSpots: [],
      numberOfSpots: 1,
      catches: [],
      largestNumber: 80,
      payout: null,
      isCalculating: false,
    );
  }

  TicketState copyWith({
    int? largestNumber,
    int? numberOfSpots,
    List<int>? spots,
    int? wager,
    List<int>? winningSpots,
    List<int>? catches,
    double? payout,
    bool? isCalculating,
  }) {
    return TicketState(
      largestNumber: largestNumber ?? this.largestNumber,
      numberOfSpots: numberOfSpots ?? this.numberOfSpots,
      spots: spots ?? this.spots,
      wager: wager ?? this.wager,
      winningSpots: winningSpots ?? this.winningSpots,
      catches: catches ?? this.catches,
      payout: payout ?? this.payout,
      isCalculating: isCalculating ?? this.isCalculating,
    );
  }
}
