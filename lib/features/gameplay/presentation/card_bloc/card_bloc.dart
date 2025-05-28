import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/auto_generate_numbers.dart';
import 'package:keno_plus/core/utils/calculate_payout.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/game_history/game_history_injections.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';
import 'package:keno_plus/features/gameplay/domain/usecases/save_ticket_usecase.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

part 'card_event.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState.initial()) {
    on<BetsChanged>(_onBetsChanged);
    on<AutoPickBets>(_onAutoPickBets);
    on<DeleteAutoPicks>(_onDeleteAutoPicks);
    on<PlayPressed>(_onPlayPressed);
  }

  final SaveTicketUsecase saveTicketUsecase = sl<SaveTicketUsecase>();

  void _onBetsChanged(BetsChanged event, Emitter<CardState> emit) {
    final bets = state.bets;
    final selectedBet = event.bet;
    final maxBets = event.maxBets;
    final emptyList = List<int>.empty();

    if (bets.contains(selectedBet)) {
      bets.remove(selectedBet);
    } else if (bets.length < maxBets) {
      bets.add(selectedBet);
    }

    emit(
      state.copyWith(
        bets: bets,
        numberOfBets: bets.length,
        // reset result lists
        winningBets: emptyList,
        matchedBets: emptyList,
      ),
    );
  }

  void _onAutoPickBets(AutoPickBets event, Emitter<CardState> emit) {
    final largestNumber = event.largestNumber;
    final numberOfBets = event.numberOfBets ?? state.numberOfBets;
    final emptyList = List<int>.empty();

    // Generate unique random numbers
    final randomBets = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfBets,
    );

    emit(
      state.copyWith(
        numberOfBets: numberOfBets,
        bets: randomBets.toList(),
        // reset result lists
        winningBets: emptyList,
        matchedBets: emptyList,
      ),
    );
  }

  void _onDeleteAutoPicks(DeleteAutoPicks event, Emitter<CardState> emit) {
    final currentBetsList = state.bets;
    final emptyList = List<int>.empty();

    if (currentBetsList.isNotEmpty) {
      emit(state.copyWith(bets: emptyList));
    }
  }

  Future<void> _onPlayPressed(
    PlayPressed event,
    Emitter<CardState> emit,
  ) async {
    final bets = state.bets;
    final largestNumber = event.numbersCount;
    final numberOfBets = state.numberOfBets;

    final randomWinningBets = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfBets,
    );

    final matchedBets = state.bets.fold<List<int>>([], (value, element) {
      if (randomWinningBets.contains(element)) {
        return [...value, element];
      }
      return value;
    });

    final payout = calculatePayout(
      numberOfSpots: bets.length,
      numberOfCatches: matchedBets.length,
      wager: event.wager,
      isClassicMode: event.gameMode == GameMode.classic,
    );

    await saveTicketUsecase.call(
      TicketModel(
        id: null,
        gameHistoryId: event.gameHistoryId,
        winningNumbers: jsonEncode(randomWinningBets),
        spots: jsonEncode(state.bets),
        catches: jsonEncode(matchedBets),
        payout: payout,
      ),
    );

    emit(
      state.copyWith(
        winningBets: randomWinningBets,
        matchedBets: matchedBets,
        payout: payout,
        isCalculating: false,
      ),
    );
  }
}
