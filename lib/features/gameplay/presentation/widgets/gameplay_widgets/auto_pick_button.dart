import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_state.dart';

class AutoPickButton extends StatelessWidget {
  const AutoPickButton({
    super.key,
    required this.cardBlocInstance,
    required this.largestNumber,
  });

  final CardBloc cardBlocInstance;
  final int largestNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cardBlocInstance, // Provide the passed CardBloc instance
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<CardBloc>().add(AutoPickBets(largestNumber: largestNumber));
            },
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.auto_awesome_sharp, size: 30),
            ),
          );
        },
      ),
    );
  }
}
