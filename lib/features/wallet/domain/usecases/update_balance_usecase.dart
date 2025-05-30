import 'package:keno_plus/features/wallet/domain/repository/wallet_repository.dart';

class UpdateBalanceUsecase {
  final WalletRepository walletRepository;

  UpdateBalanceUsecase(this.walletRepository);

  Future<void> call(String username, double newBalance) async {
    await walletRepository.updateBalance(username, newBalance);
  }
}
