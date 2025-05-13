import 'package:keno_plus/core/values/app_imports.dart';

class KenoLoginWidget extends StatefulWidget {
  const KenoLoginWidget({super.key});

  @override
  State<KenoLoginWidget> createState() => _KenoLoginWidgetState();
}

class _KenoLoginWidgetState extends State<KenoLoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _userEmailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    _userEmailFocus.addListener(_onUserEmailFocusChanged);
    _passwordFocus.addListener(_onPasswordFocusChanged);
  }

  void _onUserEmailFocusChanged() {
    if (context.mounted) {
      context.read<AuthenticationBloc>().add(
        UpdateUserEmailFocusEvent(_userEmailFocus.hasFocus),
      );
    }
  }

  void _onPasswordFocusChanged() {
    if (context.mounted) {
      context.read<AuthenticationBloc>().add(
        UpdatePasswordFocusEvent(_passwordFocus.hasFocus),
      );
    }
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _passwordController.dispose();
    _userEmailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KenoMainLayout(
      content: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: KenoFormDialog(
                logo: AppImages.logo,
                headerBackgroundColor: AppColors.primary,
                headerTitleText: AppStrings.welcomeTitle,
                headerTitleColor: AppColors.secondary,
                headerSubText: AppStrings.welcomeDesc,
                headerSubColor: AppColors.white,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _userEmailField(state, context),
                    const SizedBox(height: 16),
                    _passwordField(state, context),
                    const SizedBox(height: 16),
                    _forgetPassButton(),
                    const SizedBox(height: 16),
                    _loginButton(),
                    const SizedBox(height: 16),
                    _registerButton(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  KenoDesciptiveTextButton _registerButton(BuildContext context) {
    return KenoDesciptiveTextButton(
      descriptiveText: AppStrings.dontHaveAcc,
      descriptiveTextColor: AppColors.black,
      buttonText: AppStrings.signUp,
      buttonTextColor: AppColors.secondary,
      onPressed: () {
        context.read<AuthenticationBloc>().add(SwitchToSignupEvent());
      },
    );
  }

  KenoButton _loginButton() {
    return KenoButton(
      text: AppStrings.login,
      hasBorder: true,
      borderColor: AppColors.black,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Login logic
        }
      },
    );
  }

  KenoTextButton _forgetPassButton() {
    return KenoTextButton(
      text: AppStrings.forgetPass,
      textColor: AppColors.black,
      alignment: Alignment.centerLeft,
      onPressed: () {},
    );
  }

  KenoFormField _passwordField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _passwordController,
      fieldFocus: _passwordFocus,
      isFieldFocused: state.isPasswordFocused,
      label: AppStrings.passLabel,
      hint: AppStrings.passHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isPassword: true,
      isPasswordVisible: state.isPasswordVisible,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdatePasswordEvent(value));
        if (value.isEmpty) {
          context.read<AuthenticationBloc>().add(
            ResetPasswordVisibilityEvent(),
          );
        }
      },
      onTogglePasswordVisibility: () {
        context.read<AuthenticationBloc>().add(TogglePasswordVisibilityEvent());
      },
      validator: (value) => null,
    );
  }

  KenoFormField _userEmailField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _userEmailController,
      fieldFocus: _userEmailFocus,
      isFieldFocused: state.isUserEmailFocused,
      label: AppStrings.userLabel,
      hint: AppStrings.userHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateUserEmailEvent(value));
      },
      validator: (value) => null,
    );
  }
}
