import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/wallet/data/datasources/wallet_datasource.dart';
import 'package:keno_plus/features/wallet/data/repository/iwallet_repository.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';
import 'package:keno_plus/features/wallet/domain/usecases/create_wallet_usecase.dart';
import 'package:keno_plus/features/wallet/domain/usecases/get_balance_usecase.dart';
import 'package:keno_plus/features/wallet/domain/usecases/update_balance_usecase.dart';
import 'package:keno_plus/features/wallet/presentation/bloc/wallet_bloc.dart';

final sl = GetIt.instance;

initWalletInjections() async {
  final database = await AppDatabase().database;

  // Register WalletBloc
  sl.registerSingleton<WalletBloc>(WalletBloc());

  // Register Data Source
  sl.registerSingleton<WalletDataSource>(WalletDataSource(database));

  // Register WalletRepository
  sl.registerSingleton<WalletRepository>(IWalletRepository(sl()));

  // Register Use Cases
  sl.registerSingleton<CreateWalletUsecase>(CreateWalletUsecase(sl()));
  sl.registerSingleton<GetBalanceUsecase>(GetBalanceUsecase(sl()));
  sl.registerSingleton<UpdateBalanceUsecase>(UpdateBalanceUsecase(sl()));
}
