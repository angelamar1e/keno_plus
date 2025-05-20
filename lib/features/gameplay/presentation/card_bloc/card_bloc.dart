import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

part 'card_event.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState.initial()) {
    on<BetsChanged>(_onBetsChanged);
    on<AutoPickBets>(_onAutoPickBets);
  }

  void _onBetsChanged(BetsChanged event, Emitter<CardState> emit) {
    final bets = state.bets;
    final selectedBet = event.bet;
    final numberOfBets = state.numberOfBets;

    if (bets.contains(selectedBet)) {
      bets.remove(selectedBet);
    } else if (bets.length < numberOfBets) {
      bets.add(selectedBet);
    }

    emit(state.copyWith(bets: bets));
  }

  void _onAutoPickBets(AutoPickBets event, Emitter<CardState> emit) {
    final range = event.range;

    // generate random numbers
    final random = Random();
    final numberOfBets = event.numberOfBets ?? state.numberOfBets;

    // Generate unique random numbers
    final randomBets = <int>{};
    while (randomBets.length < numberOfBets) {
      randomBets.add(
        random.nextInt(range) + 1,
      ); // Random number between 1 and range
    }

    emit(state.copyWith(numberOfBets: numberOfBets, bets: randomBets.toList()));
  }
}
