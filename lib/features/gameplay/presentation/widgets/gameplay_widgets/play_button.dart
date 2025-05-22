// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';

import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/game_history/game_history_bloc/game_history_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_event.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/result_dialog.dart';

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
                    resultDialog(context, state);
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
