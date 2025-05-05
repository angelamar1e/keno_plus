import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/authentication/data/data_source/user_datasource.dart';
import 'package:keno_plus/features/authentication/domain/models/user.dart';
import 'package:keno_plus/features/authentication/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<Either<Fail, void>> createUser(User user) async {
    try {
      await userDataSource.createUser(user);
      return Right(null);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
