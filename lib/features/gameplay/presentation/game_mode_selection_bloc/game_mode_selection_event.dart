part of 'game_mode_selection_bloc.dart';

class GameModeSelectionEvent {}

class GameModeSelected extends GameModeSelectionEvent {
  final GameMode gameModeSelected;

  GameModeSelected({required this.gameModeSelected});
}
