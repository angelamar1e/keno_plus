import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDataSource {
  final Database database;

  UserDataSource(this.database);

  Future<void> createUser(UserModel user) async {
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
