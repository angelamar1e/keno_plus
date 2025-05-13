import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Fail, UserModel>> createUser(UserModel user);

  Future<Either<Fail, List<String>>> getUsers();

  Future<Either<AuthFailure, UserModel>> getUserByUsername(String username);
}
