import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/user_repository.dart';

class CreateUser {
  final UserRepository userRepository;

  CreateUser(this.userRepository);

  Future<Either<Fail, void>> call(UserModel user) async {
    try {
      await userRepository.createUser(user);
      return Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
