import 'package:keno_plus/core/values/app_imports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Center(
        child: KenoButton(
          text: 'Learn How to Play Keno Plus',
          icon: Icons.play_arrow,
        ),
      ),
    );
  }
}

class KenoButton extends StatelessWidget {
  final BuildContext? context;
  final VoidCallback? onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;

  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;

  const KenoButton({
    super.key,
    this.context,
    this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withAlpha(127),
              blurRadius: 16,
              spreadRadius: 2,
              offset: Offset.zero,
            ),
          ],
        ),
        child: SizedBox(
          height: 60.0, // Fixed height for the button
          width: 200.0, // Fixed width (or use constraints)
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                backgroundColor ?? AppColors.secondary,
              ),
              foregroundColor: WidgetStateProperty.all(
                foregroundColor ?? AppColors.primary,
              ),
              padding: WidgetStateProperty.all(
                padding ??
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              elevation: WidgetStateProperty.all(0),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: iconSize ?? 26.0,
                      color: iconColor,
                    ),
                    SizedBox(width: 8.0),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16.0,
                      fontWeight: fontWeight ?? FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
