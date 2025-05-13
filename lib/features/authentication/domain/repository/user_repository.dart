import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';

abstract class UserRepository {
  Future<Either<Fail, void>> createUser(User user);
}
