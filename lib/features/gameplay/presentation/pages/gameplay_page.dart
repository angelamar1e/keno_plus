// build using game config bloc
// resultsReady listener from card bloc, trigger results bloc (singleton) and handle output modal (build using results bloc)

import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/card_widget.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_slider.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/play_button.dart';
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
          final numberOfCards = state.numberOfCards;
          final gameMode = state.gameMode;
          final numbersCount = gameMode.numbersCount;

          return KenoMainLayout(
            background: KenoGameBackground(),
            content: Column(
              children: [
                // Fixed header
                KenoTopBar(text: 'Classic Keno'),

                // Expanded PageView to take available space
                Expanded(
                  flex: 3, // Give more space to the cards
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: state.numberOfCards,
                      onPageChanged: (index) {
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
                          child: CardWidget(
                            columns: gameMode.columns,
                            numbersCount: numbersCount,
                            maxBets: gameMode.maxBets,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Fixed bottom controls with less space
                Expanded(
                  flex: 1, // Give less space to controls
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Navigation buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KenoButton(
                              onPressed:
                                  state.currentCard > 0
                                      ? () {
                                        context.read<GameConfigBloc>().add(
                                          UpdateCurrentCard(
                                            state.currentCard - 1,
                                          ),
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
                                        context.read<GameConfigBloc>().add(
                                          UpdateCurrentCard(
                                            state.currentCard + 1,
                                          ),
                                        );
                                      }
                                      : null,
                              icon: Icons.arrow_forward,
                              iconColor: AppColors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),

                        // Wager controls
                        const WagerControls(),
                        const SizedBox(height: 8.0),

                        // Auto-pick button
                        AutoPickButton(
                          cardBlocInstance: currentCardBloc,
                          largestNumber: numbersCount,
                        ),

                        // Auto-pick slider
                        AutoPickNumberSlider(
                          cardBlocInstance: currentCardBloc,
                          largestNumber: numbersCount,
                          max: gameMode.maxBets,
                        ),

                        // Play button
                        PlayButton(
                          cardBlocInstances: cardBlocInstances.values.toList(),
                          numbersCount: numbersCount,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
