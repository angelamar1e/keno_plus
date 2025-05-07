// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final bool isReadOnly;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TapRegionCallback? onTapOutside;

  const TextFieldWidget({
    super.key,
    required this.labelText,
    this.isReadOnly = false,
    this.controller,
    this.onTap,
    this.onChanged,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        readOnly: isReadOnly,
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        onTapOutside: onTapOutside,
        // TODO: Add validation logic onTapOutside of the TextField
      ),
    );
  }
}

class Spacer extends StatelessWidget {
  const Spacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 7);
  }
}

Future<List<String>> _showDatePicker(BuildContext context) async {
  late String dateOfBirth;
  late int age;

  final DateTime? picked = await showDatePicker(
    context: context,
    // initialDate: lastDate,
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

class SignUpScreen extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdateController = TextEditingController();
  final ageController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen to SignUpBloc state
        BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.isSignedUp) {
              // Dispatch AuthenticationSucceeded event to AuthenticationBloc
              context.read<AuthenticationBloc>().add(
                AuthenticationSucceeded(
                  user: state.user ?? UserModel.emptyUser,
                ),
              );

              // Navigate to the home screen
              context.goNamed(AppRoutes.home);
            } else if (state.isFailedSignUp) {
              // Show error message
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.errorMessage ?? 'An error occurred'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text fields and Sign Up button
              TextFieldWidget(
                labelText: 'First Name',
                controller: firstNameController,
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Last Name',
                controller: lastNameController,
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Date of Birth',
                controller: birthdateController,
                isReadOnly: true,
                onTap:
                    () => _showDatePicker(context).then((value) {
                      if (value.isNotEmpty) {
                        // Set the date of birth and age returned from the date picker
                        birthdateController.text = value.first;
                        ageController.text = value.last;
                      }
                    }),
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Age',
                controller: ageController,
                isReadOnly: true,
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Phone Number',
                controller: phoneNumberController,
              ),
              const Spacer(),
              TextFieldWidget(labelText: 'Email', controller: emailController),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Username',
                controller: usernameController,
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Password',
                controller: passwordController,
              ),
              const Spacer(),
              TextFieldWidget(
                labelText: 'Confirm Password',
                controller: confirmPasswordController,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Access the text from the controllers
                  final firstName = firstNameController.text;
                  final lastName = lastNameController.text;
                  final email = emailController.text;
                  final birthdate = birthdateController.text;
                  final age = ageController.text;
                  final phoneNumber = phoneNumberController.text;
                  final username = usernameController.text;
                  final password = passwordController.text;

                  // Create a new user
                  UserModel newUser = UserModel(
                    firstName: firstName,
                    lastName: lastName,
                    birthdate: birthdate,
                    age: int.parse(age),
                    username: username,
                    email: email,
                    password: password,
                    phoneNumber: phoneNumber,
                  );

                  // Trigger the CreatingUser event in SignUpBloc
                  context.read<SignUpBloc>().add(CreatingUser(user: newUser));
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
