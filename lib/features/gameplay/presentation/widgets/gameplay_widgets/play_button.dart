// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_history_bloc/game_history_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_history_bloc/game_history_event.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WagerBloc, WagerState>(
      builder: (context, wagerState) {
        return BlocListener<PayoutBloc, PayoutState>(
          listener: (context, payoutState) {
            // TODO: save history when payout info is complete
          },

          // TODO: add another listener to card bloc, if state/matched bets changes, generate payout info
          child: ElevatedButton(
            onPressed: () {
              // First trigger play on all cards
              for (final bloc in cardBlocInstances) {
                bloc.add(PlayPressed(numbersCount: numbersCount));
              }
            },
            child: const Text('Play'),
          ),
        );
      },
    );
  }
}
