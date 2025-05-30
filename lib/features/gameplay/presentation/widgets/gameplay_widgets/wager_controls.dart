import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/values/app_colors.dart';
import 'package:keno_plus/core/values/app_strings.dart';
import 'package:keno_plus/core/widgets/app_widgets.dart';
import 'package:keno_plus/features/gameplay/gameplay_injections.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_event.dart';
import 'package:keno_plus/features/gameplay/presentation/wager_bloc/wager_state.dart';

class WagerControls extends StatelessWidget {
  const WagerControls({super.key});

  // TODO: add buttons to multiply wager to 2x, 3x, 5x, 10x, reset to 20, make wager a text field, remove halve wager button

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
                text: '${AppStrings.wager}${state.wager.toStringAsFixed(2)}',
                fontSize: 20.0,
                color: AppColors.white,
              ),
              KenoVerticalSpacer(spacer: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KenoButton(
                    text: AppStrings.wagerMultiplierTwo,
                    onPressed: () => context.read<WagerBloc>().add(WagerTwo()),
                  ),
                  KenoHorizontalSpacer(spacer: 4.0),
                  KenoButton(
                    text: AppStrings.wagerMultiplierThree,
                    onPressed:
                        () => context.read<WagerBloc>().add(WagerThree()),
                  ),
                  KenoHorizontalSpacer(spacer: 4.0),
                  KenoButton(
                    text: AppStrings.wagerMultiplierFive,
                    onPressed: () => context.read<WagerBloc>().add(WagerFive()),
                  ),
                  KenoHorizontalSpacer(spacer: 4.0),
                  KenoButton(
                    text: AppStrings.wagerMultiplierTen,
                    onPressed: () => context.read<WagerBloc>().add(WagerTen()),
                  ),
                  KenoHorizontalSpacer(spacer: 4.0),
                  KenoButton(
                    icon: Icons.refresh_rounded,
                    onPressed:
                        () => context.read<WagerBloc>().add(WagerReset()),
                  ),
                ],
              ),
              KenoVerticalSpacer(spacer: 4.0),
              KenoText(
                text: AppStrings.wagerMultiplierLabel,
                color: AppColors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
