import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/data/datasources/wallet_datasource.dart';
import 'package:keno_plus/features/wallet/data/models/wallet_model.dart';
import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class IWalletRepository extends WalletRepository {
  final WalletDataSource walletDataSource;

  IWalletRepository(this.walletDataSource);

  @override
  Future<Either<Fail<String>, WalletEntity>> createWallet(
    WalletModel wallet,
  ) async {
    return await walletDataSource.createWallet(wallet);
  }

  @override
  Future<Either<Fail<String>, double>> getBalance(String username) async {
    return await walletDataSource.getBalance(username);
  }

  @override
  Future<Either<Fail<String>, WalletEntity>> updateBalance(
    WalletModel wallet,
  ) async {
    return await walletDataSource.updateBalance(wallet);
  }
}
