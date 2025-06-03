import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class UpdateBalanceUsecase {
  final WalletRepository walletRepository;

  UpdateBalanceUsecase(this.walletRepository);

  Future<Either<Fail<String>, WalletEntity>> call(WalletEntity wallet) async {
    return await walletRepository.updateBalance(wallet);
  }
}
