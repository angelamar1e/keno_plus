part of 'game_config_bloc.dart';

class GameConfigEvent {}

class SetGameMode extends GameConfigEvent {}

class SetNumberOfCards extends GameConfigEvent {}

class UpdateCurrentCard extends GameConfigEvent {
  final int currentCard;

  UpdateCurrentCard(this.currentCard);
}
