import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/wallet/presentation/bloc/wallet_bloc.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        Widget content;
        switch (state.status) {
          case WalletStatus.initial:
          case WalletStatus.loading:
            content = const CircularProgressIndicator(strokeWidth: 2);
            break;
          case WalletStatus.loaded:
            final currentWallet = state.wallet;
            if (currentWallet != null) {
              content = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₱${currentWallet.balance.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );
            } else {
              content = const Text('No wallet', style: TextStyle(fontSize: 16));
            }
            break;
          case WalletStatus.error:
            content = Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            );
            break;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          constraints: const BoxConstraints(
            minWidth: 120,
            minHeight: 44,
            maxWidth: 200,
          ),
          child: Center(child: content),
        );
      },
    );
  }
}
