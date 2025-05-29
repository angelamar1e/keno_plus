part of 'game_config_bloc.dart';

class GameConfigEvent {}

class SetGameMode extends GameConfigEvent {}

class SetNumberOfTickets extends GameConfigEvent {}

class UpdateCurrentTicket extends GameConfigEvent {
  final int currentTicket;

  UpdateCurrentTicket(this.currentTicket);
}
