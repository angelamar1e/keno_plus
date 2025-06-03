part of 'wallet_bloc.dart';

enum WalletStatus { initial, loading, loaded, error }

class WalletState {
  final WalletStatus status;
  final WalletEntity? wallet;
  final String? errorMessage;

  const WalletState({
    required this.status,
    required this.wallet,
    required this.errorMessage,
  });

  factory WalletState.initial() {
    return const WalletState(
      status: WalletStatus.initial,
      errorMessage: null,
      wallet: null,
    );
  }

  WalletState copyWith({
    WalletStatus? status,
    WalletEntity? wallet,
    String? errorMessage,
    String? username,
    double? balance,
  }) {
    return WalletState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      wallet: null,
    );
  }
}
