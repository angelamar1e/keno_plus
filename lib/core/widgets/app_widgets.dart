import 'package:keno_plus/core/router/app_routes.dart';
import 'package:keno_plus/core/values/app_imports.dart';

class KenoMainLayout extends StatelessWidget {
  final Widget content;

  const KenoMainLayout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [const KenoMainBackground(), content]);
  }
}

class KenoButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? italic;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool isGlow;
  final Color? glowColor;
  final bool hasBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? margin;

  const KenoButton({
    super.key,
    this.onPressed,
    required this.text,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.italic,
    this.textColor,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.isGlow = false,
    this.glowColor,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.margin,
  });

  @override
  State<KenoButton> createState() => _KenoButtonState();
}

class _KenoButtonState extends State<KenoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAlphaAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Scale animation: normal to expanded
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Shadow alpha animation: increase visibility when pressed
    _shadowAlphaAnimation = Tween<double>(
      begin: 100,
      end: 200,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme colors for defaults
    final theme = Theme.of(context);
    final defaultBackgroundColor =
        widget.backgroundColor ?? theme.colorScheme.secondary;
    final defaultTextColor = widget.textColor ?? theme.colorScheme.onSecondary;
    final defaultIconColor = widget.iconColor ?? defaultTextColor;
    final defaultForegroundColor =
        widget.foregroundColor ?? theme.colorScheme.primary;
    final defaultBorderColor =
        widget.borderColor ?? theme.colorScheme.onPrimary;
    final defaultGlowColor = widget.glowColor ?? defaultTextColor;

    return Listener(
      onPointerDown: (_) => _controller.forward(),
      onPointerUp: (_) => _controller.reverse(),
      onPointerCancel: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: widget.margin ?? 0.0),
              decoration:
                  widget.isGlow
                      ? BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: defaultGlowColor.withAlpha(
                              _shadowAlphaAnimation.value.toInt(),
                            ),
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
                  onPressed: widget.onPressed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      defaultBackgroundColor,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      defaultForegroundColor,
                    ),
                    padding: WidgetStateProperty.all(
                      widget.padding ??
                          EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        side:
                            widget.hasBorder
                                ? BorderSide(
                                  color: defaultBorderColor,
                                  width: widget.borderWidth ?? 2.0,
                                )
                                : BorderSide.none,
                      ),
                    ),
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: widget.iconSize ?? 26.0,
                          color: defaultIconColor,
                        ),
                        SizedBox(width: 8.0),
                      ],
                      KenoText(
                        text: widget.text,
                        fontFamily:
                            widget.fontFamily ??
                            theme.textTheme.labelLarge?.fontFamily ??
                            AppFonts.inter,
                        fontSize: widget.fontSize ?? 16.0,
                        color: defaultTextColor,
                        fontWeight: widget.fontWeight ?? FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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

class KenoText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? decorationThickness;
  final Color? decorationColor;
  final bool? italic;
  final Color? color;
  final String? fontFamily;
  final bool? isGlow;
  final Color? glowColor;
  final double? glowIntensity;

  const KenoText({
    super.key,
    required this.text,
    this.fontSize,
    this.textAlign,
    this.fontWeight,
    this.textDecoration,
    this.decorationThickness,
    this.decorationColor,
    this.italic,
    this.color,
    this.fontFamily,
    this.isGlow,
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
        fontStyle: italic == true ? FontStyle.italic : FontStyle.normal,
        shadows:
            isGlow == true
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

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 16);
  }
}
