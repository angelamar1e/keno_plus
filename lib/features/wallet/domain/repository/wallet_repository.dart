import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/data/models/wallet_model.dart';
import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Fail<String>, WalletEntity>> createWallet(WalletModel wallet);
  Future<Either<Fail<String>, double>> getBalance(String username);
  Future<Either<Fail<String>, WalletEntity>> updateBalance(WalletModel wallet);
}
