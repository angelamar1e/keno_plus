import 'package:keno_plus/core/values/app_imports.dart';

/// A styled dialog widget for authentication forms with a header and content area.
class KenoFormDialogWidget extends StatelessWidget {
  // Header content
  final String headerTitleText;
  final String headerSubText;
  final String? logo;

  // Appearance customization
  final Color? headerBackgroundColor;
  final Color? headerTitleColor;
  final Color? headerSubColor;
  final Color? contentBackgroundColor;

  // Dialog content
  final Widget content;

  const KenoFormDialogWidget({
    super.key,
    // Required parameters
    required this.headerTitleText,
    required this.headerSubText,
    required this.content,
    // Optional parameters
    this.logo,
    this.headerBackgroundColor,
    this.headerTitleColor,
    this.headerSubColor,
    this.contentBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final headerBgColor = headerBackgroundColor ?? theme.colorScheme.primary;
    final contentBgColor = contentBackgroundColor ?? theme.colorScheme.surface;
    final titleColor = headerTitleColor ?? theme.colorScheme.secondary;
    final subColor = headerSubColor ?? theme.colorScheme.onPrimary;

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
                color: headerBgColor.withOpacity(0.59),
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
                      color: titleColor,
                      isGlow: true,
                    ),
                    KenoText(
                      text: headerSubText,
                      fontSize: 12.0,
                      color: subColor,
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
                  color: contentBgColor,
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

/// A styled form field widget for authentication inputs.
class KenoFormField extends StatelessWidget {
  // Input properties
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? enabled;
  final bool? autocorrect;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;

  // Label and text properties
  final String? label;
  final String? hint;
  final Color? textColor;
  final FontWeight? focusedLabelWeight;

  // Field behavior properties
  final bool isPassword;
  final bool isBirthdate;
  final bool isAge;
  final bool isPasswordVisible;

  // Icon properties
  final IconData? icon;
  final VoidCallback? iconPressed;

  // Event callbacks
  final VoidCallback? onTogglePasswordVisibility;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const KenoFormField({
    super.key,
    // Label and text properties
    this.label,
    this.hint,
    this.textColor,
    this.focusedLabelWeight,

    // Input properties
    this.controller,
    this.keyboardType,
    this.readOnly,
    this.enabled,
    this.autocorrect,
    this.autovalidateMode,
    this.validator,

    // Field behavior properties
    this.isPassword = false,
    this.isBirthdate = false,
    this.isAge = false,
    this.isPasswordVisible = false,

    // Icon properties
    this.icon,
    this.iconPressed,

    // Event callbacks
    this.onTogglePasswordVisibility,
    this.onChanged,
    this.onTap, required ,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecoration = theme.inputDecorationTheme;

    return FormField<String>(
      validator: validator,
      autovalidateMode: autovalidateMode,
      builder: (FormFieldState<String> state) {
        final bool hasError = state.hasError;

        return TextFormField(
          controller: controller,
          obscureText: isPassword ? !isPasswordVisible : false,
          style: TextStyle(
            color: textColor ?? theme.textTheme.bodyMedium?.color,
          ),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            floatingLabelStyle: inputDecoration.floatingLabelStyle?.copyWith(
              fontWeight: focusedLabelWeight ?? FontWeight.w600,
              color: hasError ? AppColors.error : null,
            ),
            prefixIcon:
                !isBirthdate
                    ? null
                    : IconButton(
                      icon: Icon(Icons.calendar_month_rounded),
                      onPressed: onTap,
                      color:
                          hasError
                              ? AppColors.error
                              : inputDecoration.prefixIconColor,
                    ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color:
                            hasError
                                ? AppColors.error
                                : inputDecoration.suffixIconColor,
                      ),
                      onPressed: onTogglePasswordVisibility,
                    )
                    : (controller?.text.isEmpty ?? true)
                    ? null
                    : IconButton(
                      icon: Icon(
                        icon,
                        color:
                            hasError
                                ? AppColors.error
                                : inputDecoration.suffixIconColor,
                      ),
                      onPressed: iconPressed,
                    ),
            contentPadding: inputDecoration.contentPadding,
            labelStyle: inputDecoration.labelStyle,
            hintStyle: inputDecoration.hintStyle,
            errorText: state.errorText,
            filled: inputDecoration.filled,
            fillColor: inputDecoration.fillColor,
            border: inputDecoration.border,
            focusedBorder: inputDecoration.focusedBorder,
            enabledBorder: inputDecoration.enabledBorder,
            errorBorder: inputDecoration.errorBorder,
            focusedErrorBorder: inputDecoration.focusedErrorBorder,
          ),
          readOnly: readOnly ?? false,
          enabled: !isAge? enabled : false,
          autocorrect: autocorrect ?? true,
          keyboardType: keyboardType,
          textInputAction:
              !isPassword ? TextInputAction.next : TextInputAction.done,
          onTap: onTap,
          onChanged: (value) {
            state.didChange(value);
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        );
      },
    );
  }
}

/// A custom text button with clean styling and underline effect on press.
class KenoTextButton extends StatefulWidget {
  // Content
  final String text;
  final VoidCallback onPressed;

  // Styling
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? decorationThickness;
  final Alignment? alignment;

  const KenoTextButton({
    super.key,
    // Required parameters
    required this.text,
    required this.onPressed,
    // Optional styling parameters
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
    final theme = Theme.of(context);
    final defaultTextColor = widget.textColor ?? theme.colorScheme.secondary;

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
          color: defaultTextColor,
          fontWeight: widget.fontWeight ?? FontWeight.w600,
          textDecoration: _isPressed ? TextDecoration.underline : null,
          decorationThickness: widget.decorationThickness,
          decorationColor: defaultTextColor,
        ),
      ),
    );
  }
}

/// A text button with descriptive label for common authentication actions.
class KenoDesciptiveTextButton extends StatelessWidget {
  // Text content
  final String descriptiveText;
  final String buttonText;

  // Styling
  final Color? descriptiveTextColor;
  final Color? buttonTextColor;

  // Event callback
  final VoidCallback onPressed;

  const KenoDesciptiveTextButton({
    super.key,
    // Required parameters
    required this.descriptiveText,
    required this.buttonText,
    required this.onPressed,
    // Optional styling parameters
    this.descriptiveTextColor,
    this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultDescriptiveColor =
        descriptiveTextColor ?? theme.textTheme.bodyMedium?.color;
    final defaultButtonColor = buttonTextColor ?? theme.colorScheme.secondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KenoText(text: descriptiveText, color: defaultDescriptiveColor),
        const SizedBox(width: 6),
        KenoTextButton(
          text: buttonText,
          textColor: defaultButtonColor,
          fontWeight: FontWeight.w900,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
