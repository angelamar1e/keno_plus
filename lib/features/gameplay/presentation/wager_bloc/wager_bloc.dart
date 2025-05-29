import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_event.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

// Bloc
class WagerBloc extends Bloc<WagerEvent, WagerState> {
  WagerBloc() : super(WagerState.initial()) {
    on<WagerHalved>(_onWagerHalved);
    on<WagerReset>(_onWagerReset);
    on<WagerMultiplied>(_onWagerMultiplied);
    on<IncreaseWager>(_onIncreaseWager);
    on<DecreaseWager>(_onDecreaseWager);
  }

  void _onWagerHalved(WagerHalved event, Emitter<WagerState> emit) {
    final newWager = state.wager / 2;
    if (newWager >= WagerState.minWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.minWager));
    }
  }

  // reset to minimum wager
  void _onWagerReset(WagerReset event, Emitter<WagerState> emit) {
    emit(state.copyWith(wager: WagerState.minWager));
  }

  // multiply wager
  void _onWagerMultiplied(WagerMultiplied event, Emitter<WagerState> emit) {
    final newWager = state.wager * event.multiplier;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  // increase wager by 1
  void _onIncreaseWager(IncreaseWager event, Emitter<WagerState> emit) {
    final newWager = state.wager + 1;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.maxWager));
    }
  }

  // decrease wager by 1
  void _onDecreaseWager(DecreaseWager event, Emitter<WagerState> emit) {
    final newWager = state.wager - 1;
    if (newWager >= WagerState.minWager) {
      emit(state.copyWith(wager: newWager));
    } else {
      emit(state.copyWith(wager: WagerState.minWager));
    }
  }
}
