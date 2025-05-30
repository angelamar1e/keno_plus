// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_config_bloc.dart';

class GameConfigState {
  final int numberOfTickets;
  final GameMode gameMode;
  final int currentTicket; // Add currentTicket property

  GameConfigState({
    required this.numberOfTickets,
    required this.gameMode,
    required this.currentTicket,
  });

  factory GameConfigState.initial() {
    return GameConfigState(
      numberOfTickets: 2,
      gameMode: GameMode.classic,
      currentTicket: 0, // Default to the first ticket
    );
  }

  GameConfigState copyWith({
    int? numberOfTickets,
    GameMode? gameMode,
    int? currentTicket,
  }) {
    return GameConfigState(
      numberOfTickets: numberOfTickets ?? this.numberOfTickets,
      gameMode: gameMode ?? this.gameMode,
      currentTicket: currentTicket ?? this.currentTicket,
    );
  }
}
