// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_event.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';

import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/result_dialog.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.cardBlocInstances,
    required this.gameMode,
  });

  final List<CardBloc> cardBlocInstances;
  final GameMode gameMode;

  bool _hasEmptyBets(List<CardBloc> cardBlocs) {
    return cardBlocs.any((bloc) => bloc.state.spots.isEmpty);
  }

  bool _isCalculating(List<CardBloc> cardBlocs) {
    return cardBlocs.any((bloc) => bloc.state.isCalculating);
  }

  @override
  Widget build(BuildContext context) {
    final hasEmptyBets = cardBlocInstances.any(
      (bloc) => bloc.state.spots.isEmpty,
    );
    final isCalculating = cardBlocInstances.any(
      (bloc) => bloc.state.isCalculating,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<WagerBloc>(create: (context) => sl<WagerBloc>()),
        BlocProvider<GameHistoryBloc>(
          create: (context) => sl<GameHistoryBloc>(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final wager = context.select((WagerBloc bloc) => bloc.state.wager);
          final user = context.select(
            (AuthenticationBloc bloc) => bloc.state.user,
          );
          final newGameHistoryId = context.select(
            (GameHistoryBloc bloc) => bloc.state.newGameHistoryId,
          );

          // Disable the button if any card is calculating or has empty bets
          final isDisabled = isCalculating || hasEmptyBets;
          final newGameHistory = GameHistoryModel(
            id: null,
            username: user?.username ?? '',
            timestamp: DateTime.now().toIso8601String(),
            gameMode: gameMode.name,
            wager: wager,
          );

          return ElevatedButton(
            onPressed:
                isDisabled
                    ? null
                    : () {
                      // save game settings history
                      context.read<GameHistoryBloc>().add(
                        SaveGameHistory(gameHistory: newGameHistory),
                      );

                      // Trigger play on all cards, draws winning numbers, and calculates payouts
                      for (final bloc in cardBlocInstances) {
                        bloc.add(
                          PlayPressed(
                            newGameHistoryId,
                            gameMode.numbersCount,
                            gameMode,
                            wager,
                          ),
                        );
                      }

                      // Show the result dialog after all cards have been played
                      showResultDialog(context, cardBlocInstances);
                    },
            child: Text('Play'),
          );
        },
      ),
    );
  }
}
