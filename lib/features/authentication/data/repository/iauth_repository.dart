import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/datasources/auth_datasource.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/user_repository.dart';

class IUserRepository extends UserRepository {
  final UserDataSource userDataSource;

  IUserRepository(this.userDataSource);

  @override
  Future<Either<Fail, void>> createUser(UserModel user) async {
    try {
      await userDataSource.createUser(user);
      return Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
