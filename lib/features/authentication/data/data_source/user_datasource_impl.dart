import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';

class UserDataSourceImpl implements UserDataSource {
  final Database database;

  UserDataSourceImpl(this.database);

  @override
  Future<void> createUser(UserModel user) async {
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
