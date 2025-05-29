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
                text: 'Wager',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Halve wager button
                  KenoIconButton(
                    icon: Icons.keyboard_double_arrow_down_rounded,
                    onPressed:
                        () => context.read<WagerBloc>().add(WagerHalved()),
                    tooltip: 'Halve wager',
                    iconColor: AppColors.white,
                  ),
                  // Decrease wager button
                  KenoIconButton(
                    onPressed:
                        () => context.read<WagerBloc>().add(DecreaseWager()),
                    icon: Icons.keyboard_arrow_down_rounded,
                    tooltip: 'Decrease wager',
                    iconColor: AppColors.white,
                  ),
                  KenoText(
                    text: '₱${state.wager.toStringAsFixed(2)}',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  // Increase wager button
                  KenoIconButton(
                    onPressed:
                        () => context.read<WagerBloc>().add(IncreaseWager()),
                    icon: Icons.keyboard_arrow_up_rounded,
                    tooltip: 'Increase wager',
                    iconColor: AppColors.white,
                  ),
                  // Double wager button
                  KenoIconButton(
                    onPressed:
                        () => context.read<WagerBloc>().add(WagerDoubled()),
                    icon: Icons.keyboard_double_arrow_up_rounded,
                    tooltip: 'Double wager',
                    iconColor: AppColors.white,
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
