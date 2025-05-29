abstract class WagerEvent {}

class WagerHalved extends WagerEvent {}

class WagerMultiplied extends WagerEvent {
  final int multiplier;

  WagerMultiplied(this.multiplier);
}

class WagerReset extends WagerEvent {}

class IncreaseWager extends WagerEvent {}

class DecreaseWager extends WagerEvent {}
