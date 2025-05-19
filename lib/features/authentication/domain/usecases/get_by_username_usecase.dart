import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/auth_failure.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class GetUserByUsername {
  final UserRepository userRepository;

  GetUserByUsername(this.userRepository);

  Future<Either<AuthFailure, UserModel>> call(String username) async {
    final result = await userRepository.getUserByUsername(username);
    return result.fold(
      (authFail) => Left(authFail),
      (user) => Right(
        UserModel(
          username: user.username,
          password: user.password,
          firstName: user.firstName,
          lastName: user.lastName,
          birthdate: user.birthdate,
          age: user.age,
          phoneNumber: user.phoneNumber,
          email: user.email,
        ),
      ),
    );
  }
}
