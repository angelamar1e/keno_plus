import 'package:keno_plus/core/router/app_routes.dart';
import 'package:keno_plus/core/values/app_imports.dart';

/// A collection of common widgets used throughout the Keno Plus app.
/// These widgets provide consistent styling and behavior.

/// Main layout for app screens with background and content.
class KenoMainLayout extends StatelessWidget {
  final Widget? background;
  final Widget? topBar;
  final Widget content;

  const KenoMainLayout({
    super.key,
    this.background,
    this.topBar,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background ?? const KenoMainBackground(),
        Scaffold(
          appBar: AppBar(title: topBar, backgroundColor: AppColors.transparent),
          body: SafeArea(child: content),
        ),
      ],
    );
  }
}

/// Primary button with animation, theming and customization options.
///
/// Features include:
/// - Press animation with scale effect
/// - Glow effect option
/// - Border customization
/// - Icon support
/// - Theme-aware defaults
class KenoButton extends StatelessWidget {
  // Content
  final String? text;
  final IconData? icon;

  // Event handling
  final VoidCallback? onPressed;

  // Text styling
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;

  // Button appearance
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final double? iconSize;
  final Color? iconColor;
  final double? margin;

  // Effects
  final bool isGlow;
  final Color? glowColor;
  final bool hasBorder;
  final Color? borderColor;
  final double? borderWidth;

  const KenoButton({
    super.key,
    // Required parameters
    this.text,
    this.onPressed,

    // Text styling
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.textColor,

    // Button appearance
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.margin,

    // Effects
    this.isGlow = false,
    this.glowColor,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Get theme colors for defaults
    final theme = Theme.of(context);
    final defaultBackgroundColor =
        backgroundColor ?? theme.colorScheme.secondary;
    final defaultTextColor = textColor ?? theme.colorScheme.primary;
    final defaultIconColor = iconColor ?? theme.colorScheme.primary;
    final defaultForegroundColor = foregroundColor ?? theme.colorScheme.primary;
    final defaultBorderColor = borderColor ?? theme.colorScheme.primary;
    final defaultGlowColor = glowColor ?? theme.colorScheme.onPrimary;

    // Define disabled colors
    final disabledBackgroundColor = defaultBackgroundColor.withOpacity(0.5);
    final disabledTextColor = defaultTextColor.withOpacity(0.5);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin ?? 0.0),
      decoration:
          isGlow
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: defaultGlowColor,
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset.zero,
                  ),
                ],
              )
              : null,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledBackgroundColor;
              }
              return defaultBackgroundColor;
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledTextColor;
              }
              return defaultForegroundColor;
            }),
            padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
                side:
                    hasBorder
                        ? BorderSide(
                          color: defaultBorderColor,
                          width: borderWidth ?? 2.0,
                        )
                        : BorderSide.none,
              ),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: iconSize ?? 26.0, color: defaultIconColor),
                if (text != null && text!.isNotEmpty) SizedBox(width: 8.0),
              ],
              if (text != null && text!.isNotEmpty)
                KenoText(
                  text: text!,
                  fontFamily:
                      fontFamily ??
                      theme.textTheme.labelLarge?.fontFamily ??
                      AppFonts.inter,
                  fontSize: fontSize ?? 16.0,
                  color: defaultTextColor,
                  fontWeight: fontWeight ?? FontWeight.w600,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom navigation bar with themed styling and navigation.
///
/// Provides:
/// - Themed appearance based on app colors
/// - Active/inactive state styling
/// - Navigation using Go Router
class KenoBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const KenoBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    // Get theme colors
    final theme = Theme.of(context);

    return BottomAppBar(
      color: theme.colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            pageIndex: 1,
            icon: Icons.home_rounded,
            label: AppStrings.home,
            onTap: () => context.goNamed(AppRoutes.home),
          ),
          const SizedBox(width: 24.0),
          _buildNavItem(
            context: context,
            pageIndex: 2,
            icon: Icons.person_rounded,
            label: AppStrings.profile,
            onTap: () => context.goNamed(AppRoutes.profile),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int pageIndex,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    // Get theme colors
    final theme = Theme.of(context);
    final isSelected = currentIndex == pageIndex;
    final color =
        isSelected ? theme.colorScheme.secondary : theme.colorScheme.onPrimary;

    return FittedBox(
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            iconSize: 32.0,
            color: color,
            onPressed: onTap,
          ),
          KenoText(text: label, fontSize: 16.0, color: color),
        ],
      ),
    );
  }
}

/// Styled text widget with glow, font variations and theme integration.
///
/// Features:
/// - Theme-aware styling
/// - Custom font weights using font variations
/// - Optional glow effect
/// - Text decoration options
class KenoText extends StatelessWidget {
  // Content
  final String text;

  // Text styling
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? decorationThickness;
  final Color? decorationColor;
  final bool italic;
  final Color? color;
  final String? fontFamily;

  // Effects
  final bool isGlow;
  final Color? glowColor;
  final double? glowIntensity;

  const KenoText({
    super.key,
    // Required parameters
    required this.text,

    // Text styling
    this.fontSize,
    this.textAlign,
    this.fontWeight,
    this.textDecoration,
    this.decorationThickness,
    this.decorationColor,
    this.italic = false,
    this.color,
    this.fontFamily,

    // Effects
    this.isGlow = false,
    this.glowColor,
    this.glowIntensity,
  });

  double _getFontWeightValue(FontWeight? weight) {
    if (weight == null) return 400;

    switch (weight) {
      case FontWeight.w100:
        return 100;
      case FontWeight.w200:
        return 200;
      case FontWeight.w300:
        return 300;
      case FontWeight.w400:
        return 400;
      case FontWeight.w500:
        return 500;
      case FontWeight.w600:
        return 600;
      case FontWeight.w700:
        return 700;
      case FontWeight.w800:
        return 800;
      case FontWeight.w900:
        return 900;
      default:
        return 400;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get theme text style and colors
    final theme = Theme.of(context);
    final defaultColor =
        color ??
        theme.textTheme.bodyMedium?.color ??
        theme.colorScheme.onBackground;
    final defaultFontFamily =
        fontFamily ?? theme.textTheme.bodyMedium?.fontFamily ?? AppFonts.inter;

    return Text(
      text,
      style: TextStyle(
        fontFamily: defaultFontFamily,
        fontSize: fontSize ?? 14.0,
        color: defaultColor,
        fontVariations: [
          FontVariation('wght', _getFontWeightValue(fontWeight)),
        ],
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        shadows:
            isGlow
                ? [
                  Shadow(
                    color: (glowColor ?? defaultColor).withAlpha(200),
                    blurRadius: (glowIntensity ?? 20) * 0.5,
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    color: (glowColor ?? defaultColor).withAlpha(100),
                    blurRadius: glowIntensity ?? 20,
                    offset: const Offset(0, 0),
                  ),
                ]
                : null,
        decoration: textDecoration ?? TextDecoration.none,
        decorationThickness: decorationThickness ?? 2.0,
        decorationColor: decorationColor ?? defaultColor,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

/// Gradient background widget for consistent app styling.
class KenoGradientBackground extends StatelessWidget {
  const KenoGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

/// Main app background with image and gradient overlay.
class KenoMainBackground extends StatelessWidget {
  const KenoMainBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.menuBg, fit: BoxFit.cover),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.black.withOpacity(0.2),
                AppColors.gradientStart.withOpacity(0.4),
                AppColors.gradientEnd.withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

/// Main app background with image and gradient overlay.
class KenoGameBackground extends StatelessWidget {
  const KenoGameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(AppImages.gameBg, fit: BoxFit.cover),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.black.withOpacity(0.2),
                AppColors.gradientStart.withOpacity(0.4),
                AppColors.gradientEnd.withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

/// Standard vertical spacing widget for consistent spacing in forms.
class KenoVerticalSpacer extends StatelessWidget {
  final double? spacer;
  const KenoVerticalSpacer({super.key, this.spacer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: spacer ?? 16);
  }
}

/// Standard horizontal spacing widget for consistent spacing in forms.
class KenoHorizontalSpacer extends StatelessWidget {
  final double? spacer;
  const KenoHorizontalSpacer({super.key, this.spacer});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: spacer ?? 16);
  }
}
