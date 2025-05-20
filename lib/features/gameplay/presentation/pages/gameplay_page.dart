// build using game config bloc
// resultsReady listener from card bloc, trigger results bloc (singleton) and handle output modal (build using results bloc)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/card_widget.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_slider.dart';

class GameplayPage extends StatelessWidget {
  const GameplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<int, CardBloc> cardBlocInstances = {};

    return Center(
      child: BlocBuilder<GameConfigBloc, GameConfigState>(
        builder: (context, state) {
          // Ensure the currentCardBloc is retrieved from the map
          if (!cardBlocInstances.containsKey(state.currentCard)) {
            cardBlocInstances[state.currentCard] = CardBloc();
          }
          final currentCardBloc = cardBlocInstances[state.currentCard]!;
          final numberOfCards = state.numberOfCards;
          final range = state.gameMode.columns * state.gameMode.rows;

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
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
                      child: CardWidget(gameMode: state.gameMode),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        state.currentCard > 0
                            ? () {
                              // Navigate to the previous card
                              context.read<GameConfigBloc>().add(
                                UpdateCurrentCard(state.currentCard - 1),
                              );
                            }
                            : null,
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed:
                        state.currentCard < numberOfCards - 1
                            ? () {
                              // Navigate to the next card
                              context.read<GameConfigBloc>().add(
                                UpdateCurrentCard(state.currentCard + 1),
                              );
                            }
                            : null,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              AutoPickButton(cardBlocInstance: currentCardBloc, range: range),
              AutoPickNumberSlider(
                range: range,
                min: 0,
                max: state.gameMode.maxBets,
                cardBlocInstance: currentCardBloc,
              ),
            ],
          );
        },
      ),
    );
  }
}
