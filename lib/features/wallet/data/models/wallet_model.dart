import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({required super.username, required super.balance});

  Map<String, dynamic> toMap() {
    return {'username': username, 'balance': balance};
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      username: map['username'] as String,
      balance: (map['balance'] as num).toDouble(),
    );
  }

  factory WalletModel.fromEntity(WalletEntity entity) {
    return WalletModel(username: entity.username, balance: entity.balance);
  }
}
