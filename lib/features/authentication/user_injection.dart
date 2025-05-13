import 'package:keno_plus/core/utils/database.dart';
import 'package:keno_plus/features/authentication/data/data_source/user_datasource.dart';
import 'package:keno_plus/features/authentication/data/data_source/user_datasource_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/authentication/data/repository/user_repository_impl.dart';
import 'package:keno_plus/features/authentication/domain/repository/user_repository.dart';
import 'package:keno_plus/features/authentication/domain/use_cases/create_user.dart';

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
