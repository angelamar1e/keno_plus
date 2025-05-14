// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:keno_plus/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.password,
    required super.firstName,
    required super.lastName,
    required super.birthdate,
    required super.age,
    required super.phoneNumber,
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
      'age': age,
      'phoneNumber': phoneNumber,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  static final emptyUser = UserModel(
    username: '',
    password: '',
    firstName: '',
    lastName: '',
    birthdate: '',
    age: 0,
    phoneNumber: '',
    email: '',
  );
}
