import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_event.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_state.dart';

class AutoPickButton extends StatelessWidget {
  const AutoPickButton(
    this.gameMode, {
    super.key,
    required this.ticketBlocInstance,
  });

  final TicketBloc ticketBlocInstance;
  final GameMode gameMode;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ticketBlocInstance,
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          return KenoIconButton(
            icon: Icons.casino_rounded,
            onPressed: () {
              context.read<TicketBloc>().add(
                AutoPickSpots(largestNumber: gameMode.numbersCount),
              );
            },
            iconSize: 42.0,
            iconColor: AppColors.secondary,
          );
        },
      ),
    );
  }
}
