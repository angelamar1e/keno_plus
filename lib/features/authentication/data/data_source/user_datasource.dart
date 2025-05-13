import 'package:keno_plus/core/values/app_imports.dart';

abstract class UserDataSource {
  Future<void> createUser(User user);
}
