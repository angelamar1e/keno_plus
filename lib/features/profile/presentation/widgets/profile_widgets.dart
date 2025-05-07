import '../../../../core/values/app_imports.dart';

class KenoInputField extends StatelessWidget {
  final TextEditingController fieldController;
  final bool? isPassword;
  final FocusNode? fieldFocus;
  final bool? isFieldFocused;
  final String label;
  final String hint;
  final Color? focusedLabelColor;
  final FontWeight? focusedLabelWeight;
  final Color? textColor;
  final VoidCallback? iconPressed;
  final IconData? icon;
  final Color? iconColor;

  const KenoInputField({
    super.key,
    required this.fieldController,
    this.isPassword,
    required this.fieldFocus,
    required this.isFieldFocused,
    required this.label,
    required this.hint,
    this.focusedLabelColor,
    this.focusedLabelWeight,
    this.textColor,
    this.iconPressed,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      focusNode: fieldFocus,
      obscureText: isPassword ?? false,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelStyle: TextStyle(
          color: isFieldFocused! ? focusedLabelColor : AppColors.black,
          fontWeight: focusedLabelWeight,
        ),
        suffixIcon:
            fieldController.text.isNotEmpty
                ? IconButton(
                  onPressed: iconPressed,
                  icon: Icon(icon),
                  color: iconColor,
                )
                : null,
      ),
    );
  }
}

class KenoTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? decorationThickness;
  final Alignment? alignment;

  const KenoTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.fontWeight,
    this.decorationThickness,
    this.alignment,
  });

  @override
  State<KenoTextButton> createState() => _KenoTextButtonState();
}

class _KenoTextButtonState extends State<KenoTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: TextButton(
        style: ButtonStyle(
          enableFeedback: false,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          minimumSize: WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          alignment: widget.alignment,
        ),
        onPressed: widget.onPressed,
        child: KenoText(
          text: widget.text,
          color: widget.textColor,
          fontWeight: widget.fontWeight,
          textDecoration: _isPressed ? TextDecoration.underline : null,
          decorationThickness: widget.decorationThickness,
          decorationColor: widget.textColor,
        ),
      ),
    );
  }
}
