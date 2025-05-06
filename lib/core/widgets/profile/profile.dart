import 'package:keno_plus/core/values/app_imports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isPasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        // This empty setState will rebuild the widget when text changes
      });
    });

    // Add focus listeners
    _emailFocus.addListener(() {
      setState(() {
        _isEmailFocused = _emailFocus.hasFocus;
      });
    });

    _passwordFocus.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KenoMainWidget(
      content: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        ),
                        color: AppColors.primary.withAlpha(100),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 32.0,
                        ),
                        child: Column(
                          children: [
                            KenoShowLogo(logo: AppImages.logo, height: 32.0),
                            SizedBox(height: 16.0),
                            KenoText(
                              text: 'Welcome to Keno Plus!',
                              fontFamily: AppFonts.grandstander,
                              fontWeight: FontWeight.w900,
                              fontSize: 32.0,
                              color: AppColors.secondary,
                              isGlow: true,
                            ),
                            KenoText(
                              text:
                                  'Step right in and let the numbers work their magic. Log in now to play and feel the thrill!',
                              fontSize: 12.0,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24.0),
                          bottomRight: Radius.circular(24.0),
                        ),
                        color: AppColors.white,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 32.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              focusNode: _emailFocus,
                              style: TextStyle(color: AppColors.black),
                              decoration: InputDecoration(
                                labelText: 'Username/email',
                                hintText: 'Enter your username or email',
                                floatingLabelStyle: TextStyle(
                                  color:
                                      _isEmailFocused
                                          ? AppColors.secondary
                                          : AppColors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              focusNode: _passwordFocus,
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              style: TextStyle(color: AppColors.black),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                floatingLabelStyle: TextStyle(
                                  color:
                                      _isPasswordFocused
                                          ? AppColors.secondary
                                          : AppColors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                                suffixIcon:
                                    _passwordController.text.isNotEmpty
                                        ? IconButton(
                                          icon: Icon(
                                            _isPasswordVisible
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            color:
                                                _isPasswordFocused
                                                    ? AppColors.secondary
                                                    : AppColors.black,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordVisible =
                                                  !_isPasswordVisible;
                                            });
                                          },
                                        )
                                        : null,
                              ),
                            ),
                            SizedBox(height: 16),
                            UnderlineTextButton(
                              text: 'Forget password?',
                              textColor: AppColors.black,
                              alignment: Alignment.centerLeft,
                              onPressed: () {},
                            ),
                            SizedBox(height: 16),
                            KenoButton(
                              text: 'Login',
                              hasBorder: true,
                              borderColor: AppColors.black,
                              onPressed: () {},
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KenoText(
                                  text: 'Don\'t have an account?',
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 6),
                                UnderlineTextButton(
                                  text: 'Sign up',
                                  textColor: AppColors.secondary,
                                  fontWeight: FontWeight.w900,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnderlineTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? decorationThickness;
  final Alignment? alignment;

  const UnderlineTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.fontWeight,
    this.decorationThickness,
    this.alignment,
  });

  @override
  State<UnderlineTextButton> createState() => _UnderlineTextButtonState();
}

class _UnderlineTextButtonState extends State<UnderlineTextButton> {
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
