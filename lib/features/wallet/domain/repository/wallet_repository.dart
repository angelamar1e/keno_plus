import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Fail<String>, WalletEntity>> createWallet(WalletEntity wallet);
  Future<Either<Fail<String>, WalletEntity>> getBalance(String username);
  Future<Either<Fail<String>, WalletEntity>> updateBalance(WalletEntity wallet);
}
