import 'package:dartz/dartz.dart';

abstract class WalletRepository {
  Future<Either<Fail, bool>> createWallet(String username);
  Future<Either<Fail, double>> getBalance(String username);
  Future<Either<Fail, bool>> updateBalance(String username, double amount);
}
