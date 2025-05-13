import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';

class CreateUser {
  final UserRepository userRepository;

  CreateUser(this.userRepository);

  Future<Either<Fail, void>> call(User user) async {
    try {
      await userRepository.createUser(user);
      return Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
