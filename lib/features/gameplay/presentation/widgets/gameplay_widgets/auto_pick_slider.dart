import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_event.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_state.dart';

class AutoPickNumberSlider extends StatelessWidget {
  final GameMode gameMode;
  final TicketBloc ticketBlocInstance;

  const AutoPickNumberSlider(
    this.gameMode, {
    required this.ticketBlocInstance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ticketBlocInstance, // Provide the passed TicketBloc instance
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          final numberOfSpots = state.numberOfSpots;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KenoText(
                text: 'Auto-Pick Spots: $numberOfSpots',
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  // Active track color (filled portion)
                  activeTrackColor: AppColors.tertiary,

                  // Inactive track color (unfilled portion)
                  inactiveTrackColor: AppColors.white.withOpacity(0.3),

                  // Thumb color (the draggable circle)
                  thumbColor: AppColors.secondary,

                  // Overlay color (appears when dragging)
                  overlayColor: AppColors.secondary.withOpacity(0.2),

                  // Value indicator color (the label that shows the value)
                  valueIndicatorColor: AppColors.secondary,
                  valueIndicatorTextStyle: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),

                  // Tick marks (division marks)
                  activeTickMarkColor: AppColors.secondary,
                  inactiveTickMarkColor: AppColors.white.withOpacity(0.5),

                  // Thumb shape and size
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12.0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20.0,
                  ),
                ),
                child: Slider(
                  value: numberOfSpots.toDouble(),
                  min: 1.0,
                  max: gameMode.maxSpots.toDouble(),
                  divisions: gameMode.maxSpots, // Number of divisions
                  label: numberOfSpots.toString(),
                  onChanged: (value) {
                    context.read<TicketBloc>().add(
                      AutoPickSpots(
                        numberOfSpots: value.toInt(),
                        largestNumber: gameMode.numbersCount,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
