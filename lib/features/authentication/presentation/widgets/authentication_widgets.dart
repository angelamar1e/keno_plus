import 'package:keno_plus/core/values/app_imports.dart';

class KenoFormDialog extends StatelessWidget {
  final String? logo;
  final Color? headerBackgroundColor;
  final Color? headerTitleColor;
  final Color? headerSubColor;
  final Color? contentBackgroundColor;
  final String headerTitleText;
  final String headerSubText;
  final Widget content;

  const KenoFormDialog({
    super.key,
    this.logo,
    this.headerBackgroundColor,
    this.headerTitleColor,
    this.headerSubColor,
    this.contentBackgroundColor,
    required this.headerTitleText,
    required this.headerSubText,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fixed header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                color:
                    headerBackgroundColor?.withAlpha(150) ??
                    AppColors.black.withAlpha(150),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 32.0,
                ),
                child: Column(
                  children: [
                    if (logo != null) ...[
                      KenoShowLogo(logo: logo!, height: 32.0),
                      const SizedBox(height: 16.0),
                    ],
                    KenoText(
                      text: headerTitleText,
                      fontFamily: AppFonts.grandstander,
                      fontWeight: FontWeight.w900,
                      fontSize: 32.0,
                      color: headerTitleColor,
                      isGlow: true,
                    ),
                    KenoText(
                      text: headerSubText,
                      fontSize: 12.0,
                      color: headerSubColor,
                    ),
                  ],
                ),
              ),
            ),
            // Scrollable content area
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                  color: contentBackgroundColor ?? AppColors.white,
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 32.0,
                    ),
                    child: content,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KenoFormField extends StatelessWidget {
  final TextEditingController fieldController;
  final FocusNode fieldFocus;
  final bool isFieldFocused;
  final bool? readOnly;
  final String? label;
  final String? hint;
  final bool isPassword;
  final bool isBirthdate;
  final bool isPasswordVisible;
  final Color? textColor;
  final Color? color;
  final FontWeight? focusedLabelWeight;
  final IconData? icon;
  final VoidCallback? iconPressed;
  final VoidCallback? onTogglePasswordVisibility;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  const KenoFormField({
    super.key,
    required this.fieldController,
    required this.fieldFocus,
    this.label,
    this.hint,
    this.isPassword = false,
    this.isBirthdate = false,
    this.readOnly,
    required this.isFieldFocused,
    this.isPasswordVisible = false,
    this.textColor,
    this.color,
    this.focusedLabelWeight,
    this.icon,
    this.iconPressed,
    this.onTogglePasswordVisibility,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      focusNode: fieldFocus,
      obscureText: isPassword ? !isPasswordVisible : false,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelStyle: TextStyle(
          color: isFieldFocused ? color : AppColors.black,
          fontWeight: focusedLabelWeight ?? FontWeight.w400,
        ),
        prefixIcon:
            !isBirthdate
                ? null
                : IconButton(
                  icon:
                      isBirthdate
                          ? Icon(Icons.calendar_month_rounded)
                          : Icon(icon),
                  color: isFieldFocused ? color : AppColors.black,
                  onPressed: () {},
                ),
        suffixIcon:
            fieldController.text.isEmpty
                ? null
                : IconButton(
                  icon:
                      isPassword
                          ? Icon(
                            isPasswordVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          )
                          : Icon(icon),
                  color: isFieldFocused ? color : AppColors.black,
                  onPressed:
                      isPassword ? onTogglePasswordVisibility : iconPressed,
                ),
        fillColor: AppColors.white,
      ),
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      textInputAction:
          !isPassword ? TextInputAction.next : TextInputAction.done,
      onTap: onTap,
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
        onPressed: widget.onPressed,
        style: ButtonStyle(
          enableFeedback: false,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          alignment: widget.alignment,
        ),
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

class KenoDesciptiveTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String descriptiveText;
  final String buttonText;
  final Color? descriptiveTextColor;
  final Color? buttonTextColor;

  const KenoDesciptiveTextButton({
    super.key,
    required this.onPressed,
    required this.descriptiveText,
    required this.buttonText,
    this.descriptiveTextColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KenoText(text: descriptiveText, color: descriptiveTextColor),
        const SizedBox(width: 6),
        KenoTextButton(
          text: buttonText,
          onPressed: onPressed,
          textColor: buttonTextColor,
          fontWeight: FontWeight.w900,
        ),
      ],
    );
  }
}
