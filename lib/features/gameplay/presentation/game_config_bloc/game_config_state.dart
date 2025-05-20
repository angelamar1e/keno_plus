// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_config_bloc.dart';

class GameConfigState {
  final int numberOfCards;
  final GameMode gameMode;
  final int currentCard; // Add currentCard property

  GameConfigState({
    required this.numberOfCards,
    required this.gameMode,
    required this.currentCard,
  });

  factory GameConfigState.initial() {
    return GameConfigState(
      numberOfCards: 1,
      gameMode: GameMode.classic,
      currentCard: 0, // Default to the first card
    );
  }

  GameConfigState copyWith({
    int? numberOfCards,
    GameMode? gameMode,
    int? currentCard,
  }) {
    return GameConfigState(
      numberOfCards: numberOfCards ?? this.numberOfCards,
      gameMode: gameMode ?? this.gameMode,
      currentCard: currentCard ?? this.currentCard,
    );
  }
}
