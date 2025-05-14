import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class Name {
  factory Name(String input) => Name._(validateName(input));

  const Name._(this.value);

  final Either<ValueFailure, String> value;
}

Either<ValueFailure, String> validateName(String input) {
  const nameRegex = r'^[a-zA-Z]+$';
  if (input.isEmpty) {
    return Left(ValueFailure.empty(input));
  } else if (input.length < 2) {
    return Left(ValueFailure.short(input));
  } else if (input.length > 50) {
    return Left(ValueFailure.long(input));
  } else if (!RegExp(nameRegex).hasMatch(input)) {
    return Left(ValueFailure.invalid(input));
  } else {
    return Right(input);
  }
}
