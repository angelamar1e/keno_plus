// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_bloc.dart';

class CardEvent {}

class BetsChanged extends CardEvent {
  final int bet;
  final int maxBets;
  BetsChanged({required this.bet, required this.maxBets});
}

class AutoPickBets extends CardEvent {
  final int? numberOfBets;
  final int largestNumber;

  AutoPickBets({required this.largestNumber, this.numberOfBets});
}

class DeleteAutoPicks extends CardEvent {}

class PlayPressed extends CardEvent {
  final int numbersCount;

  PlayPressed({required this.numbersCount});
  // draw winning bets
  // save game history
  // emit resultsReady true
}
