import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

class AutoPickNumberSlider extends StatelessWidget {
  final int min; // Minimum value of the range
  final int max; // Maximum value of the range
  final int range;
  final CardBloc cardBlocInstance;

  const AutoPickNumberSlider({
    super.key,
    required this.min,
    required this.max,
    required this.cardBlocInstance,
    required this.range,
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
              Text(
                "Auto-Pick Bets: $numberOfBets",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: numberOfBets.toDouble(),
                min: 0,
                max: max.toDouble(),
                divisions: max, // Number of divisions
                label: numberOfBets.toString(),
                onChanged: (value) {
                  context.read<CardBloc>().add(
                    AutoPickBets(numberOfBets: value.toInt(), range: range),
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
