import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';

part 'game_mode_selection_event.dart';
part 'game_mode_selection_state.dart';

class GameModeSelectionBloc
    extends Bloc<GameModeSelectionEvent, GameModeSelectionState> {
  GameModeSelectionBloc() : super(GameModeSelectionState.initial()) {
    on<GameModeSelected>(_onGameModeSelected);
  }

  void _onGameModeSelected(
    GameModeSelected event,
    Emitter<GameModeSelectionState> emit,
  ) {
    emit(state.copyWith(gameModeSelected: event.gameModeSelected));
  }
}
