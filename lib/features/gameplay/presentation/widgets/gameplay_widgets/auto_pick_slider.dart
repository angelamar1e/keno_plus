// Remove this import if not needed elsewhere
// import 'dart:math';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/core/values/app_strings.dart';
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
    // Initialize with 0 spots when widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only set to 0 if it hasn't been set yet
      if (ticketBlocInstance.state.numberOfSpots > 0) {
        ticketBlocInstance.add(
          AutoPickSpots(numberOfSpots: 0, largestNumber: gameMode.numbersCount),
        );
      }
    });

    return BlocProvider.value(
      value: ticketBlocInstance,
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          final numberOfSpots = state.numberOfSpots;
          return Row(
            mainAxisSize:
                MainAxisSize.max, // Change to max to fill the parent width
            children: [
              KenoText(text: AppStrings.autoPickSpots, color: AppColors.white),
              Expanded(
                // Wrap slider in Expanded to make it take remaining space
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // Styling remains the same
                    activeTrackColor: AppColors.tertiary,
                    inactiveTrackColor: AppColors.white.withOpacity(0.3),
                    thumbColor: AppColors.secondary,
                    overlayColor: AppColors.secondary.withOpacity(0.2),
                    valueIndicatorColor: AppColors.secondary,
                    valueIndicatorTextStyle: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    activeTickMarkColor: AppColors.secondary,
                    inactiveTickMarkColor: AppColors.white.withOpacity(0.5),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 12.0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 20.0,
                    ),
                  ),
                  child: Slider(
                    value: numberOfSpots.toDouble(),
                    min: 0.0,
                    max: gameMode.maxSpots.toDouble(),
                    divisions: gameMode.maxSpots,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
