import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/values/app_colors.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

class AutoPickNumberSlider extends StatelessWidget {
  final int max; // max allowable number of bets
  final int largestNumber; //
  final CardBloc cardBlocInstance;

  const AutoPickNumberSlider({
    super.key,
    required this.max,
    required this.cardBlocInstance,
    required this.largestNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cardBlocInstance, // Provide the passed CardBloc instance
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          final numberOfBets = state.numberOfBets;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KenoText(
                text: 'Auto-Pick Bets: $numberOfBets',
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
                  value: numberOfBets.toDouble(),
                  min: 1.0,
                  max: max.toDouble(),
                  divisions: max, // Number of divisions
                  label: numberOfBets.toString(),
                  onChanged: (value) {
                    context.read<CardBloc>().add(
                      AutoPickBets(
                        numberOfBets: value.toInt(),
                        largestNumber: largestNumber,
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
