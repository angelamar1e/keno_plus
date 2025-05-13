

import 'package:keno_plus/core/values/app_imports.dart';


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
