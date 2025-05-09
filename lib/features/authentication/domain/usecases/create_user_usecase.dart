import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class CreateUser {
  final UserRepository userRepository;

  CreateUser(this.userRepository);

  Future<Either<Fail, UserModel>> call(UserModel user) async {
    try {
      await userRepository.createUser(user);
      return Right(user);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
