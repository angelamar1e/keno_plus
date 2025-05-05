import 'package:keno_plus/core/values/app_imports.dart';

class AppGameModes {
  static const List<GameMode> modes = [
    GameMode(
      image: AppImages.classicKenoBg,
      title: AppStrings.classicKeno,
      description: AppStrings.classicKenoDesc,
      buttonText: AppStrings.playClassicKeno,
    ),
    GameMode(
      image: AppImages.miniKenoBg,
      title: AppStrings.miniKeno,
      description: AppStrings.miniKenoDesc,
      buttonText: AppStrings.playMiniKeno,
    ),
  ];
}
