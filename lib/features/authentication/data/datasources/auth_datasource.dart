import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDataSource {
  final Database database;

  UserDataSource(this.database);

  Future<UserModel> createUser(UserModel user) async {
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return user;
  }

  Future<List<String>> getUsers() async {
    final List<Map<String, Object?>> maps = await database.query('users');
    return List.generate(maps.length, (i) {
      return maps[i]['username'] as String;
    });
  }

  Future<Either<AuthFailure, UserModel>> getUserByUsername(
    String username,
  ) async {
    final List<Map<String, Object?>> maps = await database.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      return Right(
        UserModel(
          username: map['username'] as String,
          password: map['password'] as String,
          firstName: map['firstName'] as String,
          lastName: map['lastName'] as String,
          birthdate: map['birthdate'] as String,
          age: map['age'] as int,
          phoneNumber: map['phoneNumber'] as String,
          email: map['email'] as String,
        ),
      );
    } else {
      return Left(AuthFailure.userDoesNotExist(username));
    }
  }
}
