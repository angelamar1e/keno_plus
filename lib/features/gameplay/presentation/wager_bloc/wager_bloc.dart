import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_event.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

// Bloc
class WagerBloc extends Bloc<WagerEvent, WagerState> {
  WagerBloc() : super(WagerState.initial()) {
    on<WagerTwo>(_onWagerTwo);
    on<WagerReset>(_onWagerReset);
    on<WagerTen>(_onWagerTen);
    on<WagerFive>(_onWagerFive);
    on<WagerThree>(_onWagerThree);
  }

  void _onWagerTwo(WagerTwo event, Emitter<WagerState> emit) {
    final newWager = state.wager * 2;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  void _onWagerThree(WagerThree event, Emitter<WagerState> emit) {
    final newWager = state.wager * 3;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  void _onWagerFive(WagerFive event, Emitter<WagerState> emit) {
    final newWager = state.wager * 5;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  void _onWagerTen(WagerTen event, Emitter<WagerState> emit) {
    final newWager = state.wager * 10;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  // reset to minimum wager
  void _onWagerReset(WagerReset event, Emitter<WagerState> emit) {
    emit(state.copyWith(wager: WagerState.minWager));
  }
}
