import 'package:keno_plus/core/utils/database.dart';
import 'package:keno_plus/features/authentication/data/datasources/auth_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:keno_plus/features/authentication/data/repository/iauth_repository.dart';
import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';
import 'package:keno_plus/features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:keno_plus/features/authentication/presentation/authentication_bloc/authentication_bloc.dart';

final sl = GetIt.instance;

initAuthInjections() async {
  // Initialize the database
  final database = await AppDatabase().database;

  // Register UserDataSource
  sl.registerSingleton<UserDataSource>(UserDataSource(database));

  // Register UserRepository
  sl.registerSingleton<UserRepository>(IUserRepository(sl()));

  // Register CreateUser use case
  sl.registerSingleton<CreateUser>(CreateUser(sl()));

  // Register AuthenticationBloc
  sl.registerSingleton<AuthenticationBloc>(AuthenticationBloc());
}
