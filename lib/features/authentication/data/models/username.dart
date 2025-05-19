import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class Username {
  // empty constructor to prevent instantiation
  factory Username(String input) => Username._(validateUsername(input));

  const Username._(this.value);

  final Either<ValueFailure, String> value;
}

Either<ValueFailure, String> validateUsername(String input) {
  const usernameRegex = r'^[a-zA-Z0-9_]+$';

  if (input.isEmpty) {
    return Left(ValueFailure.empty(input));
  } else if (input.length < 3) {
    return Left(ValueFailure.short(input));
  } else if (input.length > 20) {
    return Left(ValueFailure.long(input));
  } else if (!RegExp(usernameRegex).hasMatch(input)) {
    return Left(ValueFailure.invalid(input));
  } else {
    return Right(input);
  }
}
