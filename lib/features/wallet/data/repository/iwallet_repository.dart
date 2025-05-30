import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/data/datasources/wallet_datasource.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class IWalletRepository extends WalletRepository {
  final WalletDataSource walletDataSource;

  IWalletRepository(this.walletDataSource);

  @override
  Future<Either<Fail, void>> createWallet(String username) async {
    return await walletDataSource.createWallet(username);
  }

  @override
  Future<Either<Fail, double>> getBalance(String username) async {
    return await walletDataSource.getBalance(username);
  }

  @override
  Future<Either<Fail, void>> updateBalance(
    String username,
    double amount,
  ) async {
    return await walletDataSource.updateBalance(username, amount);
  }
}
