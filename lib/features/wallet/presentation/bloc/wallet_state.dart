part of 'wallet_bloc.dart';

enum WalletStatus { initial, loading, loaded, error }

class WalletState {
  final WalletStatus status;
  final String username;
  final double balance;
  final String? errorMessage;

  const WalletState({
    required this.status,
    required this.errorMessage,
    required this.username,
    required this.balance,
  });

  factory WalletState.initial() {
    return const WalletState(
      status: WalletStatus.initial,
      errorMessage: null,
      username: '',
      balance: 0.0,
    );
  }

  WalletState copyWith({
    WalletStatus? status,
    String? errorMessage,
    String? username,
    double? balance,
  }) {
    return WalletState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      username: username ?? this.username,
      balance: balance ?? this.balance,
    );
  }
}
