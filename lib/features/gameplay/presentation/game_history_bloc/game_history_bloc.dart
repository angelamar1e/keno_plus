import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_history_bloc/game_history_event.dart';
import 'package:keno_plus/features/gameplay/presentation/game_history_bloc/game_history_state.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';

class GameHistoryBloc extends Bloc<GameHistoryEvent, GameHistoryState> {
  GameHistoryBloc() : super(GameHistoryState.initial()) {
    on<SaveGameHistory>(_onSaveGameHistory);
  }

  Future<void> _onSaveGameHistory(
    SaveGameHistory event,
    Emitter<GameHistoryState> emit,
  ) async {
    try {
      emit(state.copyWith(isSaving: true, error: null));

      // TODO: Implement database saving logic here
      // Example:
      // await gameHistoryRepository.saveGameHistory(
      //   cardPayouts: event.cardPayouts,
      //   timestamp: event.timestamp,
      //   gameMode: event.gameMode,
      // );

      emit(state.copyWith(
        isSaving: false,
        isSaved: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        error: e.toString(),
      ));
    }
  }
} 