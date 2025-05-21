import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_event.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

// Bloc
class WagerBloc extends Bloc<WagerEvent, WagerState> {
  WagerBloc() : super(WagerState.initial()) {
    on<WagerHalved>(_onWagerHalved);
    on<WagerDoubled>(_onWagerDoubled);
    on<IncreaseWager>(_onIncreaseWager);
    on<DecreaseWager>(_onDecreaseWager);
  }

  void _onWagerHalved(WagerHalved event, Emitter<WagerState> emit) {
    final newWager = state.wager / 2;
    if (newWager >= WagerState.minWager) {
      emit(state.copyWith(wager: newWager));
    }
  }

  void _onWagerDoubled(WagerDoubled event, Emitter<WagerState> emit) {
    final newWager = state.wager * 2;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    }
  }

  void _onIncreaseWager(IncreaseWager event, Emitter<WagerState> emit) {
    final newWager = state.wager + 1;
    if (newWager <= WagerState.maxWager) {
      emit(state.copyWith(wager: newWager));
    }
  }

  void _onDecreaseWager(DecreaseWager event, Emitter<WagerState> emit) {
    final newWager = state.wager - 1;
    if (newWager >= WagerState.minWager) {
      emit(state.copyWith(wager: newWager));
    }
  }
} 