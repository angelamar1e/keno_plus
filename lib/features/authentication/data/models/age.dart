import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class Age {
  factory Age(DateTime? input) => Age._(validateAge(input));

  const Age._(this.value);

  final Either<ValueFailure, int?> value;
}

int? getAge(DateTime? input) {
  if (input != null) {
    int age = DateTime.now().year - input.year;

    // Adjust age if the current date is before the birthday this year
    final now = DateTime.now();
    if (now.month < input.month ||
        (now.month == input.month && now.day < input.day)) {
      age--;
    }

    return age;
  } else {
    return null;
  }
}

Either<ValueFailure, int?> validateAge(DateTime? input) {
  final age = getAge(input);
  if (age == null) {
    return Left(ValueFailure.empty(''));
  } else if (age < 18) {
    return Left(ValueFailure.underage(age.toString()));
  } else {
    return Right(age);
  }
}
