import 'package:keno_plus/features/authentication/data/data_source/user_datasource.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserDataSourceImpl implements UserDataSource {
  final Database database;

  UserDataSourceImpl(this.database);

  @override
  Future<void> createUser(User user) async {
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
