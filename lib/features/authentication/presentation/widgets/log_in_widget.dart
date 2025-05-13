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
    _userEmailFocus.addListener(_onFieldFocusChanged);
    _passwordFocus.addListener(_onFieldFocusChanged);
  }

  void _onFieldFocusChanged() {
    if (context.mounted) {
      bool isFocused = _userEmailFocus.hasFocus || _passwordFocus.hasFocus;
      context.read<AuthenticationBloc>().add(UpdateFieldFocusEvent(isFocused));
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
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return KenoMainLayout(
          content: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
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
                            KenoFormField(
                              fieldController: _userEmailController,
                              fieldFocus: _userEmailFocus,
                              isFieldFocused:
                                  state.isFieldFocused &&
                                  _userEmailFocus.hasFocus,
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailHint,
                              color: AppColors.secondary,
                              textColor: AppColors.black,
                              isPassword: false,
                              onChanged: (value) {
                                context.read<AuthenticationBloc>().add(
                                  UpdateUserEmailEvent(value),
                                );
                              },
                              validator: (value) => null,
                            ),
                            const SizedBox(height: 16),
                            KenoFormField(
                              fieldController: _passwordController,
                              fieldFocus: _passwordFocus,
                              isFieldFocused:
                                  state.isFieldFocused &&
                                  _passwordFocus.hasFocus,
                              label: AppStrings.passLabel,
                              hint: AppStrings.passHint,
                              color: AppColors.secondary,
                              textColor: AppColors.black,
                              isPassword: true,
                              isPasswordVisible: state.isPasswordVisible,
                              onChanged: (value) {
                                context.read<AuthenticationBloc>().add(
                                  UpdatePasswordEvent(value),
                                );
                                if (value.isEmpty) {
                                  context.read<AuthenticationBloc>().add(
                                    ResetPasswordVisibilityEvent(),
                                  );
                                }
                              },
                              onTogglePasswordVisibility: () {
                                context.read<AuthenticationBloc>().add(
                                  TogglePasswordVisibilityEvent(),
                                );
                              },
                              validator: (value) => null,
                            ),
                            const SizedBox(height: 16),
                            KenoTextButton(
                              text: AppStrings.forgetPass,
                              textColor: AppColors.black,
                              alignment: Alignment.centerLeft,
                              onPressed: () {},
                            ),
                            const SizedBox(height: 16),
                            KenoButton(
                              text: AppStrings.login,
                              hasBorder: true,
                              borderColor: AppColors.black,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Login logic
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            KenoDesciptiveTextButton(
                              descriptiveText: AppStrings.dontHaveAcc,
                              descriptiveTextColor: AppColors.black,
                              buttonText: AppStrings.signUp,
                              buttonTextColor: AppColors.secondary,
                              onPressed: () {
                                context.read<AuthenticationBloc>().add(
                                  SwitchToSignupEvent(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
