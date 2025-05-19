class ValueFailure {
  final String? failedValue;

  const ValueFailure({this.failedValue});

  factory ValueFailure.empty(String failedValue) {
    return Empty(failedValue);
  }

  factory ValueFailure.short(String failedValue) {
    return TooShort(failedValue);
  }

  factory ValueFailure.long(String failedValue) {
    return TooLong(failedValue);
  }

  factory ValueFailure.invalid(String failedValue) {
    return Invalid(failedValue);
  }

  factory ValueFailure.duplicateUsername(String failedValue) {
    return DuplicateUsername(failedValue);
  }

  factory ValueFailure.underage(String failedValue) {
    return Underage(failedValue);
  }
}

class Empty extends ValueFailure {
  const Empty(String? failedValue) : super(failedValue: failedValue);
}

class TooShort extends ValueFailure {
  const TooShort(String? failedValue) : super(failedValue: failedValue);
}

class TooLong extends ValueFailure {
  const TooLong(String? failedValue) : super(failedValue: failedValue);
}

class Invalid extends ValueFailure {
  const Invalid(String? failedValue) : super(failedValue: failedValue);
}

class DuplicateUsername extends ValueFailure {
  const DuplicateUsername(String? failedValue)
    : super(failedValue: failedValue);
}

class Underage extends ValueFailure {
  const Underage(String? failedValue) : super(failedValue: failedValue);
}
