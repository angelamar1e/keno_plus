import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/number_box.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(this.gameMode, {super.key});

  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state.catches.isNotEmpty) {
          // generate payout info
        }
      },
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          final numbersCount =
              gameMode
                  .numbersCount; // largest number in a card, count of numbers in a card
          final maxBets =
              gameMode.maxBets; // maximum bets allowed according to game mode
          final bloc = context.read<CardBloc>();
          final bets = state.spots;
          final matches = state.catches;
          final winningBets = state.winningSpots;

          // Wrap GridView in a Container with proper constraints
          return Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gameMode.columns,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0, // Make boxes square
                ),
                itemCount: numbersCount,
                itemBuilder: (context, index) {
                  final number = index + 1;
                  return NumberBox(
                    number: number,
                    isWinningBet: winningBets.contains(number),
                    isMatch: matches.contains(number),
                    isSelected: bets.contains(number),
                    onTap: () {
                      bloc.add(BetsChanged(bet: number, maxBets: maxBets));
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
