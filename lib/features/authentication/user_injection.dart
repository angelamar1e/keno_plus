import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/authentication/domain/usecases/create_user_usecase.dart';

final sl = GetIt.instance;

initAuthInjections() async {
  // Initialize the database
  final database = await AppDatabase().database;

  // Register UserDataSource
  sl.registerSingleton<UserDataSource>(UserDataSourceImpl(database));

  // Register UserRepositoryImpl
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));

  // Register CreateUser use case
  sl.registerSingleton<CreateUser>(CreateUser(sl()));
}
