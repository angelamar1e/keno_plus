import 'package:keno_plus/core/values/app_imports.dart';

class AppTheme {
  static ThemeData get theme => darkTheme;

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.primary,
      fontFamily: AppFonts.inter,
      textTheme: _createDarkTextTheme(),
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      inputDecorationTheme: _createDarkInputDecorationTheme(),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: AppFonts.inter,
      textTheme: _createLightTextTheme(),
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      inputDecorationTheme: _createLightInputDecorationTheme(),
    );
  }

  static TextTheme _createDarkTextTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
      bodySmall: TextStyle(color: AppColors.white),
      titleLarge: TextStyle(color: AppColors.white),
      titleMedium: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.white),
      labelLarge: TextStyle(color: AppColors.white),
      labelMedium: TextStyle(color: AppColors.white),
      labelSmall: TextStyle(color: AppColors.white),
      displayLarge: TextStyle(color: AppColors.white),
      displayMedium: TextStyle(color: AppColors.white),
      displaySmall: TextStyle(color: AppColors.white),
      headlineLarge: TextStyle(color: AppColors.white),
      headlineMedium: TextStyle(color: AppColors.white),
      headlineSmall: TextStyle(color: AppColors.white),
    );
  }

  // Helper method for light text theme (if needed)
  static TextTheme _createLightTextTheme() {
    return const TextTheme(
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
      titleLarge: TextStyle(color: AppColors.black),
      titleMedium: TextStyle(color: AppColors.black),
      titleSmall: TextStyle(color: AppColors.black),
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),
      displayLarge: TextStyle(color: AppColors.black),
      displayMedium: TextStyle(color: AppColors.black),
      displaySmall: TextStyle(color: AppColors.black),
      headlineLarge: TextStyle(color: AppColors.black),
      headlineMedium: TextStyle(color: AppColors.black),
      headlineSmall: TextStyle(color: AppColors.black),
    );
  }

  static InputDecorationTheme _createLightInputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
      labelStyle: TextStyle(color: AppColors.white),
      hintStyle: TextStyle(color: AppColors.white.withAlpha(100)),
      suffixIconColor: AppColors.white,
      prefixIconColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.secondary, width: 2),
      ),
      floatingLabelStyle: TextStyle(color: AppColors.black),
      iconColor: AppColors.black,
      focusColor: AppColors.secondary,
      filled: true,
    );
  }

  static InputDecorationTheme _createDarkInputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
      labelStyle: TextStyle(color: AppColors.black),
      hintStyle: TextStyle(color: AppColors.black.withAlpha(100)),
      suffixIconColor: AppColors.black,
      prefixIconColor: AppColors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: BorderSide(color: AppColors.secondary, width: 2),
      ),
      floatingLabelStyle: TextStyle(color: AppColors.black),
      iconColor: AppColors.black,
      focusColor: AppColors.secondary,
      filled: true,
    );
  }
}
