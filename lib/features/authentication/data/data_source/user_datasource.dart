import 'package:keno_plus/features/authentication/domain/models/user.dart';

abstract class UserDataSource {
  Future<void> createUser(User user);
}
