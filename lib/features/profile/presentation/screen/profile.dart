import 'package:keno_plus/core/values/app_imports.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
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
      context.read<AuthBloc>().add(
        UpdateUserEmailFocusEvent(_userEmailFocus.hasFocus),
      );
    }
  }

  void _onPasswordFocusChanged() {
    if (context.mounted) {
      context.read<AuthBloc>().add(
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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: KenoFormDialogWidget(
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
                      isFieldFocused: state.isUserEmailFocused,
                      label: AppStrings.userLabel,
                      hint: AppStrings.userHint,
                      color: AppColors.secondary,
                      textColor: AppColors.black,
                      isPassword: false,
                      onChanged: (value) {
                        context.read<AuthBloc>().add(
                          UpdateUserEmailEvent(value),
                        );
                      },
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    KenoFormField(
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
                        context.read<AuthBloc>().add(
                          UpdatePasswordEvent(value),
                        );
                        if (value.isEmpty) {
                          context.read<AuthBloc>().add(
                            ResetPasswordVisibilityEvent(),
                          );
                        }
                      },
                      onTogglePasswordVisibility: () {
                        context.read<AuthBloc>().add(
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
                        context.read<AuthBloc>().add(SwitchToSignupEvent());
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
