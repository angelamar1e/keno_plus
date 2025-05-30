// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:keno_plus/core/utils/game_modes.dart';

class TicketEvent {}

class SpotsChanged extends TicketEvent {
  final int spot;
  final int maxSpots;
  SpotsChanged({required this.spot, required this.maxSpots});
}

class AutoPickSpots extends TicketEvent {
  final int? numberOfSpots;
  final int largestNumber;

  AutoPickSpots({required this.largestNumber, this.numberOfSpots});
}

class DeleteAutoPicks extends TicketEvent {}

class PlayPressed extends TicketEvent {
  final int numbersCount;
  final int? gameHistoryId;
  final GameMode gameMode;
  final double wager;

  PlayPressed(this.gameHistoryId, this.numbersCount, this.gameMode, this.wager);
  // draw winning spots
}
