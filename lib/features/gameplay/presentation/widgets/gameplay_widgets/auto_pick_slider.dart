import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_colors.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

class AutoPickNumberSlider extends StatelessWidget {
  final GameMode gameMode;
  final CardBloc cardBlocInstance;

  const AutoPickNumberSlider(
    this.gameMode, {
    required this.cardBlocInstance,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cardBlocInstance, // Provide the passed CardBloc instance
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          final numberOfBets = state.numberOfSpots;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Auto-Pick Bets: $numberOfBets",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Slider(
                value: numberOfBets.toDouble(),
                min: 1.0,
                max: gameMode.maxBets.toDouble(),
                divisions: gameMode.maxBets, // Number of divisions
                label: numberOfBets.toString(),
                onChanged: (value) {
                  context.read<CardBloc>().add(
                    AutoPickBets(
                      numberOfBets: value.toInt(),
                      largestNumber: gameMode.numbersCount,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
