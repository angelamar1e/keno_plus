import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/auto_generate_numbers.dart';
import 'package:keno_plus/core/utils/keno_payout_table.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

part 'card_event.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState.initial()) {
    on<BetsChanged>(_onBetsChanged);
    on<AutoPickBets>(_onAutoPickBets);
    on<DeleteAutoPicks>(_onDeleteAutoPicks);
    on<PlayPressed>(_onPlayPressed);
  }

  void _onBetsChanged(BetsChanged event, Emitter<CardState> emit) {
    final bets = state.bets;
    final selectedBet = event.bet;
    final numberOfBets = state.numberOfBets;
    final maxBets = event.maxBets;

    if (bets.contains(selectedBet)) {
      bets.remove(selectedBet);
    } else if (bets.length < maxBets) {
      bets.add(selectedBet);
    }

    emit(
      state.copyWith(
        bets: bets,
        winningBets: List.empty(),
        matchedBets: List.empty(),
      ),
    );
  }

  void _onAutoPickBets(AutoPickBets event, Emitter<CardState> emit) {
    final largestNumber = event.largestNumber;
    final numberOfBets = event.numberOfBets ?? state.numberOfBets;

    // Generate unique random numbers
    final randomBets = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfBets,
    );

    emit(
      state.copyWith(
        numberOfBets: numberOfBets,
        bets: randomBets.toList(),
        winningBets: List.empty(),
        matchedBets: List.empty(),
      ),
    );
  }

  void _onDeleteAutoPicks(DeleteAutoPicks event, Emitter<CardState> emit) {
    final currentBetsList = state.bets;
    final emptyBetsList = List<int>.empty();

    if (currentBetsList.isNotEmpty) {
      emit(state.copyWith(bets: emptyBetsList));
    }
  }

  void _onPlayPressed(PlayPressed event, Emitter<CardState> emit) {
    final largestNumber = event.numbersCount;
    final numberOfBets = state.numberOfBets;
    final isClassicMode = event.isClassicMode;

    // Generate winning numbers
    final randomWinningBets = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfBets,
    );

    // Find matching numbers
    final matchedBets = state.bets.fold<List<int>>([], (value, element) {
      if (randomWinningBets.contains(element)) {
        return [...value, element];
      }
      return value;
    });

    // Calculate payout
    final payout = KenoPayoutTable.calculatePayout(
      numberOfSpots: state.bets.length,
      numberOfCatches: matchedBets.length,
      wager: state.wager.toDouble(),
      isClassicMode: isClassicMode,
    );

    emit(
      state.copyWith(
        winningBets: randomWinningBets,
        matchedBets: matchedBets,
        amountWon: payout,
      ),
    );
  }
}
