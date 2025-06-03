import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/data/models/wallet_model.dart';
import 'package:sqflite/sqflite.dart';

class WalletDataSource {
  final Database database;

  WalletDataSource(this.database);

  Future<Either<Fail<String>, WalletModel>> createWallet(
    WalletModel wallet,
  ) async {
    try {
      await database.insert(
        'wallets',
        wallet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Right(wallet);
    } catch (e) {
      return Left(Fail('Failed to create wallet: $e'));
    }
  }

  Future<Either<Fail<String>, double>> getBalance(String username) async {
    final result = await database.query(
      'wallets',
      columns: ['balance'],
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      final wallet = WalletModel.fromMap(result.first);
      return Right(wallet.balance);
    } else {
      return Left(Fail('Wallet not found for username: $username'));
    }
  }

  Future<Either<Fail<String>, WalletModel>> updateBalance(
    WalletModel wallet,
  ) async {
    try {
      final result = await database.update(
        'wallets',
        {'balance': wallet.balance},
        where: 'username = ?',
        whereArgs: [wallet.username],
      );

      if (result > 0) {
        return Right(wallet);
      } else {
        return Left(
          Fail('Failed to update balance for username: ${wallet.username}'),
        );
      }
    } catch (e) {
      return Left(Fail('Failed to update balance: $e'));
    }
  }
}
