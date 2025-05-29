import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return GestureDetector(
            onTap: () {
              context.read<TicketBloc>().add(
                AutoPickSpots(largestNumber: gameMode.numbersCount),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.auto_awesome_sharp,
                size: 30,
                color: AppColors.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
