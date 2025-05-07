import 'package:keno_plus/core/values/app_imports.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onSignUpPressed;

  const LoginFormWidget({
    super.key,
    this.onLoginPressed,
    this.onForgotPasswordPressed,
    this.onSignUpPressed,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _isPasswordVisible = false;
  final TextEditingController _userController = TextEditingController();
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
    _userController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _authDialogHeader(
              headerColor: AppColors.primary.withAlpha(100),
              logo: AppImages.logo,
              headerTitleText: AppStrings.welcomeTitle, headerSubText: AppStrings.welcomeDesc,
            ),
            _authDialogBody(),
          ],
        ),
      ),
    );
  }

  Widget _authDialogHeader({
    Color? headerColor,
    required String logo,
    required String headerTitleText,
    required String headerSubText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: headerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
        child: Column(
          children: [
            KenoShowLogo(logo: logo, height: 32.0),
            const SizedBox(height: 16.0),
            KenoText(
              text: headerTitleText,
              fontFamily: AppFonts.grandstander,
              fontWeight: FontWeight.w900,
              fontSize: 32.0,
              color: AppColors.secondary,
              isGlow: true,
            ),
            KenoText(
              text: headerSubText,
              fontSize: 12.0,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _authDialogBody() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KenoInputField(
              fieldController: _userController,
              fieldFocus: _emailFocus,
              isFieldFocused: _isEmailFocused,
              textColor: AppColors.black,
              label: AppStrings.userLabel,
              hint: AppStrings.userHint,
              focusedLabelColor: AppColors.secondary,
              focusedLabelWeight: FontWeight.w900,
            ),
            const SizedBox(height: 16),
            KenoInputField(
              fieldController: _passwordController,
              fieldFocus: _passwordFocus,
              isFieldFocused: _isPasswordFocused,
              isPassword: _isPasswordVisible,
              textColor: AppColors.black,
              label: AppStrings.passLabel,
              hint: AppStrings.passHint,
              focusedLabelColor: AppColors.secondary,
              focusedLabelWeight: FontWeight.w900,
              icon:
                  _isPasswordVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
              iconColor:
                  _isPasswordFocused ? AppColors.secondary : AppColors.black,
              iconPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 16),
            KenoTextButton(
              text: AppStrings.forgetPass,
              textColor: AppColors.black,
              alignment: Alignment.centerLeft,
              onPressed: widget.onForgotPasswordPressed ?? () {},
            ),
            const SizedBox(height: 16),
            KenoButton(
              text: AppStrings.login,
              hasBorder: true,
              borderColor: AppColors.black,
              onPressed: widget.onLoginPressed ?? () {},
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const KenoText(
                  text: AppStrings.dontHaveAcc,
                  color: AppColors.black,
                ),
                const SizedBox(width: 6),
                KenoTextButton(
                  text: 'Sign up',
                  textColor: AppColors.secondary,
                  fontWeight: FontWeight.w900,
                  onPressed: widget.onSignUpPressed ?? () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
