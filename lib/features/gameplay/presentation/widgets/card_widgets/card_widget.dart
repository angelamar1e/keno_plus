import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/number_box.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.gameMode});

  final GameMode gameMode;
  // final CardBloc cardBloc;

  @override
  Widget build(BuildContext context) {
    int rows = gameMode.rows;
    int columns = gameMode.columns;

    return Center(
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          final bets = state.bets;
          final bloc = context.read<CardBloc>();

          // Generate the grid of NumberBox widgets
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: rows * columns,
            itemBuilder: (context, index) {
              final number = index + 1; // Numbers start at 1
              return NumberBox(
                number: number,
                isSelected: bets.contains(number),
                onTap: () {
                  bloc.add(BetsChanged(bet: number));
                },
              );
            },
          );
        },
      ),
    );
  }
}
