import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_event.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_state.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/ticket_widgets/number_box.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget(this.gameMode, {super.key});

  final GameMode gameMode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc, TicketState>(
      listener: (context, state) {
        if (state.catches.isNotEmpty) {
          // generate payout info
        }
      },
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          final numbersCount = gameMode.numbersCount;
          final maxSpots = gameMode.maxSpots;
          final bloc = context.read<TicketBloc>();
          final spots = state.spots;
          final catches = state.catches;
          final winningSpots = state.winningSpots;

          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            clipBehavior: Clip.none, // Remove clipping that adds spacing
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gameMode.columns,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1.0,
            ),
            itemCount: numbersCount,
            itemBuilder: (context, index) {
              final number = index + 1;
              return Container(
                margin: const EdgeInsets.all(
                  2.0,
                ),
                child: NumberBox(
                  number: number,
                  isWinningSpot: winningSpots.contains(number),
                  isMatch: catches.contains(number),
                  isSelected: spots.contains(number),
                  onTap: () {
                    bloc.add(SpotsChanged(spot: number, maxSpots: maxSpots));
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
