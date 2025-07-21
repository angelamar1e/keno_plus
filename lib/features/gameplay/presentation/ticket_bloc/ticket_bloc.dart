import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/auto_generate_numbers.dart';
import 'package:keno_plus/core/utils/calculate_payout.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/game_history/game_history_injections.dart';
import 'package:keno_plus/features/gameplay/data/models/ticket_model.dart';
import 'package:keno_plus/features/gameplay/domain/usecases/save_ticket_usecase.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_event.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState.initial()) {
    on<SpotsChanged>(_onSpotsChanged);
    on<AutoPickSpots>(_onAutoPickSpots);
    on<DeleteAutoPicks>(_onDeleteAutoPicks);
    on<PlayPressed>(_onPlayPressed);
  }

  final SaveTicketUsecase saveTicketUsecase = sl<SaveTicketUsecase>();

  void _onSpotsChanged(SpotsChanged event, Emitter<TicketState> emit) {
    final spots = state.spots;
    final selectedSpot = event.spot;
    final maxSpots = event.maxSpots;
    final emptyList = List<int>.empty();

    if (spots.contains(selectedSpot)) {
      spots.remove(selectedSpot);
    } else if (spots.length < maxSpots) {
      spots.add(selectedSpot);
    }

    emit(
      state.copyWith(
        spots: spots,
        numberOfSpots: spots.length,
        // reset result lists
        winningSpots: emptyList,
        catches: emptyList,
      ),
    );
  }

  void _onAutoPickSpots(AutoPickSpots event, Emitter<TicketState> emit) {
    final largestNumber = event.largestNumber;
    final numberOfSpots = event.numberOfSpots ?? state.numberOfSpots;
    final emptyList = List<int>.empty();

    // Generate unique random numbers
    final randomSpots = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfSpots,
    );

    emit(
      state.copyWith(
        numberOfSpots: numberOfSpots,
        spots: randomSpots.toList(),
        // reset result lists
        winningSpots: emptyList,
        catches: emptyList,
      ),
    );
  }

  void _onDeleteAutoPicks(DeleteAutoPicks event, Emitter<TicketState> emit) {
    final currentSpotsList = state.spots;
    final emptyList = List<int>.empty();

    if (currentSpotsList.isNotEmpty) {
      emit(state.copyWith(spots: emptyList));
    }
  }

  Future<void> _onPlayPressed(
    PlayPressed event,
    Emitter<TicketState> emit,
  ) async {
    final spots = state.spots;
    final largestNumber = event.numbersCount;
    final numberOfSpots = state.numberOfSpots;

    final randomWinningSpots = autoGenerateNumbersList(
      max: largestNumber,
      size: numberOfSpots,
    );

    final catches = state.spots.fold<List<int>>([], (value, element) {
      if (randomWinningSpots.contains(element)) {
        return [...value, element];
      }
      return value;
    });

    final payout = calculatePayout(
      numberOfSpots: spots.length,
      numberOfCatches: catches.length,
      wager: event.wager,
      isClassicMode: event.gameMode == GameMode.classic,
    );

    await saveTicketUsecase.call(
      TicketModel(
        id: null,
        gameHistoryId: event.gameHistoryId,
        winningNumbers: jsonEncode(randomWinningSpots.toList()),
        spots: jsonEncode(state.spots),
        catches: jsonEncode(catches),
        payout: payout,
      ),
    );

    emit(
      state.copyWith(
        winningSpots: randomWinningSpots.toList(),
        catches: catches,
        payout: payout,
        isCalculating: false,
      ),
    );
  }
}
