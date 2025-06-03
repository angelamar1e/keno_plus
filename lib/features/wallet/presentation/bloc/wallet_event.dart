part of 'wallet_bloc.dart';

class WalletEvent {}

class CreateWallet extends WalletEvent {
  WalletModel wallet;

  CreateWallet(this.wallet);
}

class DecreaseBalance extends WalletEvent {
  double amountToDecrease;

  DecreaseBalance(this.amountToDecrease);
}

class IncreaseBalance extends WalletEvent {
  double amountToIncrease;

  IncreaseBalance(this.amountToIncrease);
}
