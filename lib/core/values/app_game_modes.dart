import 'app_imports.dart';

class GameModeStrings {
  final String image;
  final String title;
  final String description;
  final String buttonText;

  const GameModeStrings({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class AppGameModes {
  static const List<GameModeStrings> modes = [
    GameModeStrings(
      image: AppImages.classicKenoBg,
      title: AppStrings.classicKeno,
      description: AppStrings.classicKenoDesc,
      buttonText: AppStrings.playClassicKeno,
    ),
    GameModeStrings(
      image: AppImages.miniKenoBg,
      title: AppStrings.miniKeno,
      description: AppStrings.miniKenoDesc,
      buttonText: AppStrings.playMiniKeno,
    ),
  ];
}
