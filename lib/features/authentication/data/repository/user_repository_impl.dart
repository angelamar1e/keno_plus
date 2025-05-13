import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/values/app_imports.dart';

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
