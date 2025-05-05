// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final int age;
  final String phoneNumber;
  final String email;
  final String username;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate.toIso8601String(),
      'age': age,
      'phoneNumber': phoneNumber,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
