import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';

abstract class PayoutEvent {}

class CalculatePayouts extends PayoutEvent {
  final List<CardBloc> cardBlocInstances;
  final double wager;
  final bool isClassicMode;

  CalculatePayouts({
    required this.cardBlocInstances,
    required this.wager,
    required this.isClassicMode,
  });
}

class ResetPayouts extends PayoutEvent {}
