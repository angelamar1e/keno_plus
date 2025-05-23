import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/values/app_colors.dart';
import 'package:keno_plus/core/widgets/app_widgets.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_event.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

class WagerControls extends StatelessWidget {
  const WagerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<WagerBloc>(),
      child: BlocBuilder<WagerBloc, WagerState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KenoText(
                text: 'Wager: \$${state.wager.toStringAsFixed(2)}',
                fontSize: 16.0,
                color: AppColors.white,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decrease wager button
                  IconButton(
                    onPressed: () {
                      context.read<WagerBloc>().add(DecreaseWager());
                    },
                    icon: const Icon(Icons.remove),
                    tooltip: 'Decrease wager',
                    color: AppColors.white,
                  ),
                  // Halve wager button
                  IconButton(
                    onPressed: () {
                      context.read<WagerBloc>().add(WagerHalved());
                    },
                    icon: const Icon(Icons.exposure_neg_1),
                    tooltip: 'Halve wager',
                    color: AppColors.white,
                  ),
                  // Double wager button
                  IconButton(
                    onPressed: () {
                      context.read<WagerBloc>().add(WagerDoubled());
                    },
                    icon: const Icon(Icons.exposure_plus_1),
                    tooltip: 'Double wager',
                    color: AppColors.white,
                  ),
                  // Increase wager button
                  IconButton(
                    onPressed: () {
                      context.read<WagerBloc>().add(IncreaseWager());
                    },
                    icon: const Icon(Icons.add),
                    tooltip: 'Increase wager',
                    color: AppColors.white,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
