import 'package:dartz/dartz.dart';
import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class CreateWalletUsecase {
  final WalletRepository walletRepository;

  CreateWalletUsecase(this.walletRepository);

  Future<Either<Fail, void>> call(String username) async {
    return await walletRepository.createWallet(username);
  }
}
