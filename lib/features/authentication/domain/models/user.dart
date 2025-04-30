// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final int age;
  final String username;
  final String email;
  final String password;
  final String phoneNumber;

  User({
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.age,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate.toIso8601String(),
      'age': age,
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}
