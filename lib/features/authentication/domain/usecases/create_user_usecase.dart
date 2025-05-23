import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class CreateUser {
  final UserRepository userRepository;

  CreateUser(this.userRepository);

  Future<Either<Fail, UserModel>> call(UserModel user) async {
    final result = await userRepository.createUser(user);
    return result;
  }
}
