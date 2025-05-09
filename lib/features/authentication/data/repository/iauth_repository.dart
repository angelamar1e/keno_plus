import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/datasources/auth_datasource.dart';
import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class IUserRepository extends UserRepository {
  final UserDataSource userDataSource;

  IUserRepository(this.userDataSource);

  @override
  Future<Either<Fail, UserModel>> createUser(UserModel user) async {
    try {
      await userDataSource.createUser(user);
      return Right(user);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<String>>> getUsers() async {
    try {
      final users = await userDataSource.getUsers();
      return Right(users);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
