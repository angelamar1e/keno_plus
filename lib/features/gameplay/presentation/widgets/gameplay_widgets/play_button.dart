// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';

import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_history_bloc/game_history_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_event.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.cardBlocInstances,
    required this.numbersCount,
  });

  final List<CardBloc> cardBlocInstances;
  final int numbersCount;

  bool _hasEmptyBets(List<CardBloc> cardBlocs) {
    return cardBlocs.any((bloc) => bloc.state.bets.isEmpty);
  }

  void _showPayoutsDialog(BuildContext context, PayoutState state) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Game Results'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...state.cardPayouts!.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Spots: ${entry.value.spots}'),
                          Text('Catches: ${entry.value.catches}'),
                          Text(
                            'Amount Won: \$${entry.value.amountWon.toStringAsFixed(2)}',
                            style: TextStyle(
                              color:
                                  entry.value.amountWon > 0
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total Won: \$${state.totalAmountWon.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          state.totalAmountWon > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PayoutBloc>(create: (context) => sl<PayoutBloc>()),
        BlocProvider<WagerBloc>(create: (context) => sl<WagerBloc>()),
        BlocProvider<GameHistoryBloc>(create: (context) => GameHistoryBloc()),
      ],
      child: BlocBuilder<WagerBloc, WagerState>(
        builder: (context, wagerState) {
          return BlocBuilder<PayoutBloc, PayoutState>(
            builder: (context, payoutState) {
              return BlocListener<PayoutBloc, PayoutState>(
                listener: (context, state) {
                  if (state.hasPayouts && !state.isCalculating) {
                    _showPayoutsDialog(context, state);
                  }
                },
                child: Builder(
                  builder: (context) {
                    final hasEmptyBets = _hasEmptyBets(cardBlocInstances);
                    final isDisabled =
                        payoutState.isCalculating || hasEmptyBets;

                    return ElevatedButton(
                      onPressed:
                          isDisabled
                              ? null
                              : () {
                                // Reset payouts before starting new game
                                context.read<PayoutBloc>().add(ResetPayouts());

                                // Trigger play on all cards
                                for (final bloc in cardBlocInstances) {
                                  bloc.add(
                                    PlayPressed(numbersCount: numbersCount),
                                  );
                                }

                                // calculate payouts for all cards
                                context.read<PayoutBloc>().add(
                                  CalculatePayouts(
                                    cardBlocInstances: cardBlocInstances,
                                    wager: wagerState.wager,
                                    isClassicMode:
                                        true, // TODO: get from game config
                                  ),
                                );
                              },
                      child: Text(
                        payoutState.isCalculating
                            ? 'Calculating...'
                            : hasEmptyBets
                            ? 'Select Numbers'
                            : 'Play',
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
