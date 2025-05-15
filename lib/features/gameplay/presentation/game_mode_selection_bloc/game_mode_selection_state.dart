part of 'game_mode_selection_bloc.dart';

final class GameModeSelectionState {
  final GameMode gameModeSelected;
  final bool showSelectionModal;

  GameModeSelectionState({
    required this.gameModeSelected,
    required this.showSelectionModal,
  });

  GameModeSelectionState copyWith({
    GameMode? gameModeSelected,
    bool? showSelectonModal,
  }) {
    return GameModeSelectionState(
      gameModeSelected: gameModeSelected ?? this.gameModeSelected,
      showSelectionModal: showSelectionModal,
    );
  }

  factory GameModeSelectionState.initial() {
    return GameModeSelectionState(
      gameModeSelected: GameMode.classic,
      showSelectionModal: false,
    );
  }
}
