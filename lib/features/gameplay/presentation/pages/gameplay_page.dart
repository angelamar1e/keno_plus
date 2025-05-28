import 'package:keno_plus/core/utils/game_modes.dart';
import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/card_widget.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_slider.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/play_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/result_dialog.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/wager_controls.dart';

class GameplayPage extends StatefulWidget {
  const GameplayPage({super.key});

  @override
  State<GameplayPage> createState() => _GameplayPageState();
}

class _GameplayPageState extends State<GameplayPage> {
  late final PageController pageController;
  final Map<int, CardBloc> cardBlocInstances = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameConfigBloc, GameConfigState>(
      listener: (context, state) {
        pageController.animateToPage(
          state.currentCard,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: BlocBuilder<GameConfigBloc, GameConfigState>(
        builder: (context, state) {
          // Ensure the currentCardBloc is retrieved from the map
          if (!cardBlocInstances.containsKey(state.currentCard)) {
            cardBlocInstances[state.currentCard] = CardBloc();
          }

          final currentCardBloc = cardBlocInstances[state.currentCard]!;
          final numberOfCards =
              state.numberOfCards; // number of purchased cards
          final GameMode gameMode = state.gameMode;
          final numbersCount =
              gameMode
                  .numbersCount; // largest number in a card, count of numbers in a card

          return KenoMainLayout(
            background: KenoGameBackground(),
            content: Stack(
              children: [
                Column(
                  children: [
                    KenoTopBar(text: 'Classic Keno'),
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: state.numberOfCards,
                        onPageChanged: (index) {
                          // Dispatch an event to update the current card
                          context.read<GameConfigBloc>().add(
                            UpdateCurrentCard(index),
                          );
                        },
                        itemBuilder: (context, index) {
                          if (!cardBlocInstances.containsKey(index)) {
                            cardBlocInstances[index] = CardBloc();
                          }

                          return BlocProvider.value(
                            value: cardBlocInstances[index]!,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CardWidget(
                                columns: gameMode.columns,
                                numbersCount: numbersCount,
                                maxBets: gameMode.maxBets,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KenoButton(
                          onPressed:
                              state.currentCard > 0
                                  ? () {
                                    // Navigate to the previous card
                                    context.read<GameConfigBloc>().add(
                                      UpdateCurrentCard(state.currentCard - 1),
                                    );
                                  }
                                  : null,
                          icon: Icons.arrow_back,
                          iconColor: AppColors.black,
                        ),
                        const SizedBox(width: 16),
                        KenoButton(
                          onPressed:
                              state.currentCard < numberOfCards - 1
                                  ? () {
                                    // Navigate to the next card
                                    context.read<GameConfigBloc>().add(
                                      UpdateCurrentCard(state.currentCard + 1),
                                    );
                                  }
                                  : null,
                          icon: Icons.arrow_forward,
                          iconColor: AppColors.black,
                        ),
                      ],
                    ),

                    // Wager controls
                    const WagerControls(),
                    const SizedBox(height: 16),

                    // button to auto-pick bets, according to number set in the slider
                    AutoPickButton(
                      cardBlocInstance: currentCardBloc,
                      largestNumber: numbersCount,
                    ),

                    // automatically auto-picks bets on slider change
                    AutoPickNumberSlider(
                      cardBlocInstance: currentCardBloc,
                      largestNumber: numbersCount,
                      max: gameMode.maxBets,
                    ),

                    PlayButton(
                      cardBlocInstances: cardBlocInstances.values.toList(),
                      gameMode: gameMode,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
