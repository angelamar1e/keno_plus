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
      value: ticketBlocInstance, // Provide the passed TicketBloc instance
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              context.read<TicketBloc>().add(
                AutoPickSpots(largestNumber: gameMode.numbersCount),
              );
            },
            icon: const Icon(Icons.casino_rounded),
            iconSize: 32,
            splashRadius: 32,
            color: AppColors.secondary,
          );
        },
      ),
    );
  }
}
