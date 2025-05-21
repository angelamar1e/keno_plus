import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';

abstract class UserDataSource {
  Future<void> createUser(UserModel user);
}
