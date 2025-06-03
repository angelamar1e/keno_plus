import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/game_history/game_history_injections.dart';
import 'package:keno_plus/features/wallet/data/models/wallet_model.dart';
import 'package:keno_plus/features/wallet/domain/usecases/create_wallet_usecase.dart';
import 'package:keno_plus/features/wallet/domain/usecases/get_balance_usecase.dart';
import 'package:keno_plus/features/wallet/domain/usecases/update_balance_usecase.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState.initial()) {
    on<CreateWallet>(_onCreateWallet);
    on<DecreaseBalance>(_onDecreaseBalance);
    on<IncreaseBalance>(_onIncreaseBalance);
  }

  final CreateWalletUsecase createWalletUsecase = sl<CreateWalletUsecase>();
  final GetBalanceUsecase getBalanceUsecase = sl<GetBalanceUsecase>();
  final UpdateBalanceUsecase updateBalanceUsecase = sl<UpdateBalanceUsecase>();

  Future<void> _onCreateWallet(
    CreateWallet event,
    Emitter<WalletState> emit,
  ) async {
    final result = await createWalletUsecase(event.wallet);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.toString(),
            status: WalletStatus.error,
          ),
        );
      },
      (newWallet) {
        // Handle success case
        emit(
          state.copyWith(
            status: WalletStatus.loaded,
            username: newWallet.username,
            balance: newWallet.balance,
          ),
        );
      },
    );
  }

  Future<void> _onDecreaseBalance(
    DecreaseBalance event,
    Emitter<WalletState> emit,
  ) async {
    final updatedBalance = state.balance - event.amountToDecrease;
    final updatedWallet = WalletModel(
      username: state.username,
      balance: updatedBalance,
    );

    emit(state.copyWith(status: WalletStatus.loading));

    final result = await updateBalanceUsecase.call(updatedWallet);

    result.fold(
      (failure) {
        // Handle failure case
        emit(
          state.copyWith(
            errorMessage: failure.toString(),
            status: WalletStatus.error,
          ),
        );
      },
      (_) {
        // Handle success case
        emit(
          state.copyWith(status: WalletStatus.loaded, balance: updatedBalance),
        );
      },
    );
  }

  Future<void> _onIncreaseBalance(
    IncreaseBalance event,
    Emitter<WalletState> emit,
  ) async {
    final updatedBalance = state.balance + event.amountToIncrease;
    final updatedWallet = WalletModel(
      username: state.username,
      balance: updatedBalance,
    );

    emit(state.copyWith(status: WalletStatus.loading));

    final result = await updateBalanceUsecase.call(updatedWallet);

    result.fold(
      (failure) {
        // Handle failure case
        emit(
          state.copyWith(
            errorMessage: failure.toString(),
            status: WalletStatus.error,
          ),
        );
      },
      (_) {
        // Handle success case
        emit(
          state.copyWith(status: WalletStatus.loaded, balance: updatedBalance),
        );
      },
    );
  }
}
