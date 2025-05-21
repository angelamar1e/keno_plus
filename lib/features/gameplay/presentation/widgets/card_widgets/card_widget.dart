import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/number_box.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.columns,
    required this.numbersCount,
    required this.maxBets,
  });

  final int columns;
  final int numbersCount;
  final int maxBets;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WagerBloc, WagerState>(
      builder: (context, wagerState) {
        return Column(
          children: [
            BlocListener<CardBloc, CardState>(
              listener: (context, state) {
                if (state.matchedBets.isNotEmpty) {
                  // TODO: generate payout info
                }
              },
              child: Center(
                child: BlocBuilder<CardBloc, CardState>(
                  builder: (context, state) {
                    final bets = state.bets;
                    final matches = state.matchedBets;
                    final winningBets = state.winningBets;
                    final bloc = context.read<CardBloc>();

                    // Generate the grid of NumberBox widgets
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: numbersCount,
                      itemBuilder: (context, index) {
                        final number = index + 1; // Numbers start at 1
                        return NumberBox(
                          number: number,
                          isWinningBet: winningBets.contains(number),
                          isMatch: matches.contains(number),
                          isSelected: bets.contains(number),
                          onTap: () {
                            bloc.add(
                              BetsChanged(bet: number, maxBets: maxBets),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
