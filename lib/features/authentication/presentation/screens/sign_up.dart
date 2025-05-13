// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keno_plus/core/utils/password_utils.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';
import 'package:keno_plus/features/authentication/presentation/bloc/authentication_bloc.dart';

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

  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    birthdateController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dispose();
  }

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // Check if the user is authenticated
        if (state.isAuthenticated) {
          return const Center(child: Text('User is already authenticated'));
          // If authenticated, navigate to the home screen
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Sign Up')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text field for first name
                TextFieldWidget(
                  labelText: 'First Name',
                  controller: firstNameController,
                ),
                Spacer(),
                // Text field for last name
                TextFieldWidget(
                  labelText: 'Last Name',
                  controller: lastNameController,
                ),
                Spacer(),
                // Datepicker for date of birth
                TextFieldWidget(
                  labelText: 'Date of Birth',
                  controller: birthdateController,
                  isReadOnly: true,
                  onTap:
                      () => _showDatePicker(context).then((value) {
                        // Set the date of birth and age returned from the date picker
                        birthdateController.text = value.first;
                        ageController.text = value.last;
                      }),
                ),
                Spacer(),
                // date for age
                TextFieldWidget(
                  labelText: 'Age',
                  controller: ageController,
                  isReadOnly: true,
                ),
                // text field for phone number
                TextFieldWidget(
                  labelText: 'Phone Number',
                  controller: phoneNumberController,
                ),
                // Text field for email
                TextFieldWidget(
                  labelText: 'Email',
                  controller: emailController,
                ),
                Spacer(),
                // text field for username
                TextFieldWidget(
                  labelText: 'Username',
                  controller: usernameController,
                ),
                // Text field for password
                TextFieldWidget(
                  labelText: 'Password',
                  controller: passwordController,
                ),
                Spacer(),
                // Text field for confirm password
                TextFieldWidget(
                  labelText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                Spacer(),
                // Sign Up button
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
                    final password = PasswordUtils.hashPassword(
                      passwordController.text,
                    );
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
                    context.read<AuthenticationBloc>().add(
                      CreatingUser(user: newUser),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
