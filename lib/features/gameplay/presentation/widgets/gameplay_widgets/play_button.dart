// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_strings.dart';
import 'package:keno_plus/core/widgets/app_widgets.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/game_history/data/models/game_history_model.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_event.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';

import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/game_history/presentation/game_history_bloc/game_history_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_event.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_state.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/result_dialog.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    required this.ticketBlocInstances,
    required this.gameMode,
  });

  final List<TicketBloc> ticketBlocInstances;
  final GameMode gameMode;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        for (final bloc in widget.ticketBlocInstances)
          BlocListener<TicketBloc, TicketState>(
            bloc: bloc,
            listener: (context, state) {
              // Force rebuild when ticket states change
              setState(() {});
            },
          ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WagerBloc>(create: (context) => sl<WagerBloc>()),
          BlocProvider<GameHistoryBloc>(
            create: (context) => sl<GameHistoryBloc>(),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => sl<AuthenticationBloc>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            // Now use widget.ticketBlocInstances since we're in a State class
            final hasEmptyBets = widget.ticketBlocInstances.any(
              (bloc) => bloc.state.spots.isEmpty,
            );
            final isCalculating = widget.ticketBlocInstances.any(
              (bloc) => bloc.state.isCalculating,
            );

            final wager = context.select((WagerBloc bloc) => bloc.state.wager);
            final user = context.select(
              (AuthenticationBloc bloc) => bloc.state.user,
            );
            final newGameHistoryId = context.select(
              (GameHistoryBloc bloc) => bloc.state.newGameHistoryId,
            );

            // Disable the button if any ticket is calculating or has empty bets
            final isDisabled = isCalculating || hasEmptyBets;
            final newGameHistory = GameHistoryModel(
              id: null,
              username: user?.username ?? '',
              timestamp: DateTime.now().toIso8601String(),
              gameMode: widget.gameMode.name,
              wager: wager,
            );

            return KenoButton(
              onPressed:
                  isDisabled
                      ? null
                      : () {
                        // save game settings history
                        context.read<GameHistoryBloc>().add(
                          SaveGameHistory(gameHistory: newGameHistory),
                        );

                        // Trigger play on all tickets, draws winning numbers, and calculates payouts
                        for (final bloc in widget.ticketBlocInstances) {
                          bloc.add(
                            PlayPressed(
                              newGameHistoryId,
                              widget.gameMode.numbersCount,
                              widget.gameMode,
                              wager,
                            ),
                          );
                        }

                        // Wait for all tickets to complete calculations before showing dialog
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (context.mounted) {
                            showResultDialog(
                              context,
                              widget.ticketBlocInstances,
                            );
                          }
                        });
                      },
              text: AppStrings.playButtonText,
            );
          },
        ),
      ),
    );
  }
}
