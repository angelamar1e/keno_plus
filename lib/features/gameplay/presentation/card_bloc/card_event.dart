// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_bloc.dart';

class CardEvent {}

class BetsChanged extends CardEvent {
  final int bet;
  BetsChanged({required this.bet});
}

class AutoPickBets extends CardEvent {
  final int? numberOfBets;
  final int range;

  AutoPickBets({required this.range, this.numberOfBets});
}

class WagerHalved extends CardEvent {}

class WagerDoubled extends CardEvent {}

class IncreaseWager extends CardEvent {}

class DecreaseWager extends CardEvent {}

class DeleteAutoPicks extends CardEvent {}

class PlayPressed extends CardEvent {
  // draw winning bets
  // save game history
  // emit resultsReady true
}
