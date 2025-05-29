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
          final numbersCount =
              gameMode
                  .numbersCount; // largest number in a ticket, count of numbers in a ticket
          final maxSpots =
              gameMode.maxSpots; // maximum spots allowed according to game mode
          final bloc = context.read<TicketBloc>();
          final spots = state.spots;
          final catches = state.catches;
          final winningSpots = state.winningSpots;

          // Use LayoutBuilder to ensure proper sizing
          return LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(12.0), // Reduced padding
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gameMode.columns,
                    mainAxisSpacing: 6, // Reduced spacing
                    crossAxisSpacing: 6,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: numbersCount,
                  itemBuilder: (context, index) {
                    final number = index + 1;
                    return NumberBox(
                      number: number,
                      isWinningSpot: winningSpots.contains(number),
                      isMatch: catches.contains(number),
                      isSelected: spots.contains(number),
                      onTap: () {
                        bloc.add(
                          SpotsChanged(spot: number, maxSpots: maxSpots),
                        );
                      },
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
