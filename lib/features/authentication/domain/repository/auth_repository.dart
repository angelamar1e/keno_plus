import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Fail, void>> createUser(UserModel user);
}
