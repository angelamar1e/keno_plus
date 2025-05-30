import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/game_history/domain/usecases/save_game_history_usecase.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_event.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_state.dart';

class GameHistoryBloc extends Bloc<GameHistoryEvent, GameHistoryState> {
  GameHistoryBloc(this.saveGameHistory) : super(GameHistoryState.initial()) {
    on<SaveGameHistory>(_onSaveGameHistory);
  }

  final SaveGameHistoryUseCase saveGameHistory;

  Future<void> _onSaveGameHistory(
    SaveGameHistory event,
    Emitter<GameHistoryState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));

    final result = await saveGameHistory.call(event.gameHistory);

    result.fold(
      (failure) {
        emit(state.copyWith(isSaving: false));
      },
      (newId) {
        emit(
          state.copyWith(
            isSaving: false,
            isSaved: true,
            newGameHistoryId: newId,
          ),
        );
      },
    );
  }
}
