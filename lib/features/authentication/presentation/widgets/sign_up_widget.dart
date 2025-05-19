import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

class KenoSignUpWidget extends StatefulWidget {
  const KenoSignUpWidget({super.key});

  @override
  State<KenoSignUpWidget> createState() => _KenoSignUpWidgetState();
}

class _KenoSignUpWidgetState extends State<KenoSignUpWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _birthdayFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    _firstNameFocus.addListener(_onFieldFocusChanged);
    _lastNameFocus.addListener(_onFieldFocusChanged);
    _birthdayFocus.addListener(_onFieldFocusChanged);
    _ageFocus.addListener(_onFieldFocusChanged);
    _phoneNumberFocus.addListener(_onFieldFocusChanged);
    _userNameFocus.addListener(_onFieldFocusChanged);
    _emailFocus.addListener(_onFieldFocusChanged);
    _passwordFocus.addListener(_onFieldFocusChanged);
  }

  void _onFieldFocusChanged() {
    if (context.mounted) {
      bool isFocused =
          _firstNameFocus.hasFocus ||
          _lastNameFocus.hasFocus ||
          _birthdayFocus.hasFocus ||
          _ageFocus.hasFocus ||
          _phoneNumberFocus.hasFocus ||
          _userNameFocus.hasFocus ||
          _emailFocus.hasFocus ||
          _passwordFocus.hasFocus;
      context.read<AuthenticationBloc>().add(UpdateFieldFocusEvent(isFocused));
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _birthdayFocus.dispose();
    _ageFocus.dispose();
    _phoneNumberFocus.dispose();
    _userNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.isAuthenticated) {
          return const Center(child: Text(AppStrings.alreadyAuth));
        }
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
                            _firstNameField(state, context),
                            VerticalSpacer(),
                            _lastNameField(state, context),
                            VerticalSpacer(),
                            _birthdateField(state, context),
                            VerticalSpacer(),
                            _ageField(state, context),
                            VerticalSpacer(),
                            _phoneField(state, context),
                            VerticalSpacer(),
                            _emailField(state, context),
                            VerticalSpacer(),
                            _userNameField(state, context),
                            VerticalSpacer(),
                            _passwordField(state, context),
                            VerticalSpacer(),
                            _signInButton(context),
                            VerticalSpacer(),
                            _registerButton(context),
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

  KenoButton _registerButton(BuildContext context) {
    return KenoButton(
      text: AppStrings.register,
      hasBorder: true,
      borderColor: AppColors.black,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final firstName = _firstNameController.text;
          final lastName = _lastNameController.text;
          final email = _emailController.text;
          final birthdate = _birthdayController.text;
          final age = _ageController.text;
          final phoneNumber = _phoneNumberController.text;
          final username = _userNameController.text;
          final password = PasswordUtils.hashPassword(_passwordController.text);
          // final confirmPassword = confirmPasswordController.text;

          User newUser = User(
            firstName: firstName,
            lastName: lastName,
            birthdate: birthdate,
            age: int.parse(age),
            username: username,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
          );

          // Trigger the CreatingUser event
          context.read<AuthenticationBloc>().add(CreatingUser(user: newUser));
        }
      },
    );
  }

  KenoDesciptiveTextButton _signInButton(BuildContext context) {
    return KenoDesciptiveTextButton(
      descriptiveText: AppStrings.alreadyHaveAcc,
      descriptiveTextColor: AppColors.black,
      buttonText: AppStrings.signIn,
      buttonTextColor: AppColors.secondary,
      onPressed: () {
        context.read<AuthenticationBloc>().add(SwitchToSignupEvent());
      },
    );
  }

  KenoFormField _passwordField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _passwordController,
      fieldFocus: _passwordFocus,
      isFieldFocused: state.isFieldFocused && _passwordFocus.hasFocus,
      label: AppStrings.passLabel,
      hint: AppStrings.passHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
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
      keyboardType: TextInputType.visiblePassword,
    );
  }

  KenoFormField _userNameField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _userNameController,
      fieldFocus: _userNameFocus,
      isFieldFocused: state.isFieldFocused && _userNameFocus.hasFocus,
      label: AppStrings.userNameLabel,
      hint: AppStrings.userNameHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateUserEmailEvent(value));
      },
      validator: (value) => null,
    );
  }

  KenoFormField _emailField(AuthenticationState state, BuildContext context) {
    return KenoFormField(
      fieldController: _emailController,
      fieldFocus: _emailFocus,
      isFieldFocused: state.isFieldFocused && _emailFocus.hasFocus,
      label: AppStrings.emailLabel,
      hint: AppStrings.emailHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateUserEmailEvent(value));
      },
      validator: (value) => null,
      keyboardType: TextInputType.emailAddress,
    );
  }

  KenoFormField _phoneField(AuthenticationState state, BuildContext context) {
    return KenoFormField(
      fieldController: _phoneNumberController,
      fieldFocus: _phoneNumberFocus,
      isFieldFocused: state.isFieldFocused && _phoneNumberFocus.hasFocus,
      label: AppStrings.phoneLabel,
      hint: AppStrings.phoneHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateUserEmailEvent(value));
      },
      validator: (value) => null,
      keyboardType: TextInputType.phone,
    );
  }

  KenoFormField _ageField(AuthenticationState state, BuildContext context) {
    return KenoFormField(
      fieldController: _ageController,
      fieldFocus: _ageFocus,
      isFieldFocused: state.isFieldFocused && _ageFocus.hasFocus,
      hint: AppStrings.birthDateHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateBirthDateEvent(value));
      },
      readOnly: true,
    );
  }

  KenoFormField _birthdateField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _birthdayController,
      fieldFocus: _birthdayFocus,
      isFieldFocused: state.isFieldFocused && _birthdayFocus.hasFocus,
      hint: AppStrings.birthDateHint,
      readOnly: true,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: true,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateBirthDateEvent(value));
      },
      onTap:
          () => _showDatePicker(context).then((value) {
            // Set the date of birth and age returned from the date picker
            _birthdayController.text = value.first;
            _ageController.text = value.last;
          }),
    );
  }

  KenoFormField _lastNameField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _lastNameController,
      fieldFocus: _lastNameFocus,
      isFieldFocused: state.isFieldFocused && _lastNameFocus.hasFocus,
      label: AppStrings.lastNameLabel,
      hint: AppStrings.lastNameHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateLastNameEvent(value));
      },
      validator: (value) => null,
      keyboardType: TextInputType.name,
    );
  }

  KenoFormField _firstNameField(
    AuthenticationState state,
    BuildContext context,
  ) {
    return KenoFormField(
      fieldController: _firstNameController,
      fieldFocus: _firstNameFocus,
      isFieldFocused: state.isFieldFocused && _firstNameFocus.hasFocus,
      label: AppStrings.firstNameLabel,
      hint: AppStrings.firstNameHint,
      color: AppColors.secondary,
      textColor: AppColors.black,
      isBirthdate: false,
      isPassword: false,
      onChanged: (value) {
        context.read<AuthenticationBloc>().add(UpdateFirstNameEvent(value));
      },
      validator: (value) => null,
      keyboardType: TextInputType.name,
    );
  }
}

Future<List<String>> _showDatePicker(BuildContext context) async {
  late String dateOfBirth;
  late int age;

  final DateTime? picked = await showDatePicker(
    context: context,
    // initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    // latest valid date is at least 18 years from now
    lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
  );

  if (picked != null) {
    dateOfBirth = '${picked.month + picked.day + picked.year}';
    age = DateTime.now().year - picked.year;
  }

  return [dateOfBirth.toString(), age.toString()];
}
