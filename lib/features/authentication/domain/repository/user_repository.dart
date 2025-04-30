import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';

abstract class UserRepository {
  Future<Either<Fail, void>> createUser(User user);
}
