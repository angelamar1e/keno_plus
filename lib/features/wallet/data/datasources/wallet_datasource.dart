import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

class WalletDataSource {
  final Database database;

  WalletDataSource(this.database);

  Future<Either<Fail, void>> createWallet(String username) async {
    try {
      await database.insert('wallets', {
        'username': username,
        'balance': 0.0,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
      return Right(null);
    } catch (e) {
      return Left(Fail('Failed to create wallet: $e'));
    }
  }

  Future<Either<Fail, double>> getBalance(String username) async {
    final result = await database.query(
      'wallets',
      columns: ['balance'],
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return Right(result.first['balance'] as double);
    } else {
      return Left(Fail('Wallet not found for username: $username'));
    }
  }

  Future<Either<Fail, void>> updateBalance(
    String username,
    double amount,
  ) async {
    try {
      final result = await database.update(
        'wallets',
        {'balance': amount},
        where: 'username = ?',
        whereArgs: [username],
      );

      if (result > 0) {
        return Right(null);
      } else {
        return Left(Fail('Failed to update balance for username: $username'));
      }
    } catch (e) {
      return Left(Fail('Failed to update balance: $e'));
    }
  }
}
