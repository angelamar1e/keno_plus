import 'package:dartz/dartz.dart';

abstract class WalletRepository {
  Future<Either<Fail, void>> createWallet(String username);
  Future<Either<Fail, double>> getBalance(String username);
  Future<Either<Fail, void>> updateBalance(String username, double amount);
}
