import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class GetBalanceUsecase {
  final WalletRepository walletRepository;

  GetBalanceUsecase(this.walletRepository);

  Future<Either<Fail<String>, WalletEntity>> call(String username) async {
    return await walletRepository.getBalance(username);
  }
}
