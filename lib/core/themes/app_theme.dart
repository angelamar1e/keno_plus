import 'package:keno_plus/core/values/app_imports.dart';

/// Main theme configuration for the Keno Plus app.
///
/// Defines both dark and light themes with consistent styling across the app.
/// The default theme is set to dark theme.
class AppTheme {
  /// Current app theme - defaults to dark theme
  static ThemeData get theme => darkTheme;

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      // Base theme properties
      scaffoldBackgroundColor: AppColors.primary,
      fontFamily: AppFonts.inter,

      // Text styles for different typography elements
      textTheme: _createDarkTextTheme(),

      // Color scheme for consistent UI coloring
      colorScheme: ColorScheme.dark(
        // Base properties
        brightness: Brightness.dark,

        // Primary colors - main brand colors
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary.withOpacity(0.7),
        onPrimaryContainer: AppColors.white,

        // Secondary colors - accent colors
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary.withOpacity(0.7),
        onSecondaryContainer: AppColors.white,

        // Surface colors - used for cards, sheets, and menus
        surface: AppColors.white,
        onSurface: AppColors.black,
        surfaceVariant: AppColors.white.withOpacity(0.8),
        onSurfaceVariant: AppColors.black,

        // Background colors - used for screen backgrounds
        background: AppColors.primary,
        onBackground: AppColors.white,

        // Error colors - used for error states and validation
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.error.withOpacity(0.7),
        onErrorContainer: AppColors.white,

        // Tertiary colors - additional accents if needed
        tertiary: AppColors.secondary,
        onTertiary: AppColors.white,
        tertiaryContainer: AppColors.secondary.withOpacity(0.7),
        onTertiaryContainer: AppColors.white,

        // Other UI colors - used for miscellaneous UI elements
        outline: AppColors.secondary.withOpacity(0.5),
        outlineVariant: AppColors.secondary.withOpacity(0.3),
        shadow: Colors.black,
        scrim: Colors.black.withOpacity(0.3),
        inverseSurface: AppColors.black,
        onInverseSurface: AppColors.white,
        inversePrimary: AppColors.secondary,
      ),

      // Input decoration for form fields
      inputDecorationTheme: _createDarkInputDecorationTheme(),
    );
  }

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      // Base theme properties
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: AppFonts.inter,

      // Text styles for different typography elements
      textTheme: _createLightTextTheme(),

      // Color scheme for consistent UI coloring
      colorScheme: ColorScheme.light(
        // Base properties
        brightness: Brightness.light,

        // Primary colors - main brand colors
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary.withOpacity(0.1),
        onPrimaryContainer: AppColors.primary,

        // Secondary colors - accent colors
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary.withOpacity(0.1),
        onSecondaryContainer: AppColors.secondary,

        // Surface colors - used for cards, sheets, and menus
        surface: AppColors.white,
        onSurface: AppColors.black,
        surfaceVariant: AppColors.white.withOpacity(0.7),
        onSurfaceVariant: AppColors.black,

        // Background colors - used for screen backgrounds
        background: AppColors.white,
        onBackground: AppColors.black,

        // Error colors - used for error states and validation
        error: AppColors.error,
        onError: AppColors.white,
        errorContainer: AppColors.error.withOpacity(0.1),
        onErrorContainer: AppColors.error,

        // Tertiary colors - additional accents if needed
        tertiary: AppColors.secondary,
        onTertiary: AppColors.white,
        tertiaryContainer: AppColors.secondary.withOpacity(0.1),
        onTertiaryContainer: AppColors.secondary,

        // Other UI colors - used for miscellaneous UI elements
        outline: AppColors.black.withOpacity(0.2),
        outlineVariant: AppColors.black.withOpacity(0.1),
        shadow: Colors.black.withOpacity(0.1),
        scrim: Colors.black.withOpacity(0.2),
        inverseSurface: AppColors.primary,
        onInverseSurface: AppColors.white,
        inversePrimary: AppColors.secondary,
      ),

      // Input decoration for form fields
      inputDecorationTheme: _createLightInputDecorationTheme(),
    );
  }

  /// Create text theme for dark mode
  static TextTheme _createDarkTextTheme() {
    return const TextTheme(
      // Body text styles
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),

      // Title text styles
      titleLarge: TextStyle(color: AppColors.black),
      titleMedium: TextStyle(color: AppColors.black),
      titleSmall: TextStyle(color: AppColors.black),

      // Label text styles (buttons, etc)
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),

      // Display text styles (large headers)
      displayLarge: TextStyle(color: AppColors.black),
      displayMedium: TextStyle(color: AppColors.black),
      displaySmall: TextStyle(color: AppColors.black),

      // Headline text styles
      headlineLarge: TextStyle(color: AppColors.black),
      headlineMedium: TextStyle(color: AppColors.black),
      headlineSmall: TextStyle(color: AppColors.black),
    );
  }

  /// Create text theme for light mode
  static TextTheme _createLightTextTheme() {
    return const TextTheme(
      // Body text styles
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),

      // Title text styles
      titleLarge: TextStyle(color: AppColors.black),
      titleMedium: TextStyle(color: AppColors.black),
      titleSmall: TextStyle(color: AppColors.black),

      // Label text styles (buttons, etc)
      labelLarge: TextStyle(color: AppColors.black),
      labelMedium: TextStyle(color: AppColors.black),
      labelSmall: TextStyle(color: AppColors.black),

      // Display text styles (large headers)
      displayLarge: TextStyle(color: AppColors.black),
      displayMedium: TextStyle(color: AppColors.black),
      displaySmall: TextStyle(color: AppColors.black),

      // Headline text styles
      headlineLarge: TextStyle(color: AppColors.black),
      headlineMedium: TextStyle(color: AppColors.black),
      headlineSmall: TextStyle(color: AppColors.black),
    );
  }

  /// Input decoration theme for light mode
  static InputDecorationTheme _createLightInputDecorationTheme() {
    return InputDecorationTheme(
      // Padding and spacing
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 24.0,
      ),

      // Text styling
      labelStyle: const TextStyle(color: AppColors.white),
      hintStyle: TextStyle(color: AppColors.white.withOpacity(0.39)),
      floatingLabelStyle: const TextStyle(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),

      // Icon colors
      iconColor: AppColors.secondary,
      suffixIconColor: AppColors.secondary,
      prefixIconColor: AppColors.secondary,

      // Colors and fills
      focusColor: AppColors.secondary,
      fillColor: AppColors.white,
      filled: true,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  /// Input decoration theme for dark mode
  static InputDecorationTheme _createDarkInputDecorationTheme() {
    return InputDecorationTheme(
      // Padding and spacing
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18.0,
        horizontal: 24.0,
      ),

      // Text styling
      labelStyle: const TextStyle(color: AppColors.black),
      hintStyle: TextStyle(color: AppColors.black.withOpacity(0.39)),
      floatingLabelStyle: const TextStyle(
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
      ),

      // Icon colors
      iconColor: AppColors.secondary,
      suffixIconColor: AppColors.secondary,
      prefixIconColor: AppColors.secondary,

      // Colors and fills
      focusColor: AppColors.secondary,
      fillColor: AppColors.white,
      filled: true,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  /// Date picker theme data for consistent date picker styling
  static DatePickerThemeData get datePickerTheme {
    return DatePickerThemeData(
      // Header styling
      headerBackgroundColor: AppColors.secondary,
      headerForegroundColor: AppColors.white,

      // Day cells styling
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return null; // Use default for other states
      }),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        }
        return null; // Use default for other states
      }),

      // Dialog styling
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,

      // Shape and divider
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      dividerColor: AppColors.black.withOpacity(0.2),

      // Button and title styling
      todayForegroundColor: const WidgetStatePropertyAll(AppColors.primary),
      todayBackgroundColor: WidgetStatePropertyAll(
        AppColors.primary.withOpacity(0.1),
      ),
      yearForegroundColor: const WidgetStatePropertyAll(AppColors.black),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return null; // Use default for other states
      }),
    );
  }

  /// Creates a themed date picker for use throughout the app
  static Widget themeDatePicker(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Use the dedicated datePickerTheme
        datePickerTheme: datePickerTheme,

        // Only override the button style
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(AppColors.black),
            overlayColor: WidgetStatePropertyAll(
              AppColors.primary.withOpacity(0.1),
            ),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
      ),
      child: child!,
    );
  }
}
