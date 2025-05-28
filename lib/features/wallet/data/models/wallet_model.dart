import 'package:keno_plus/features/wallet/domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({required super.username, required super.balance});

  Map<String, dynamic> toMap() {
    return {'username': username, 'balance': balance};
  }
}
