import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class EmailAddress {
  factory EmailAddress(String input) => EmailAddress._(validateEmail(input));

  const EmailAddress._(this.value);

  final Either<ValueFailure, String> value;
}

Either<ValueFailure, String> validateEmail(String input) {
  const emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  if (input.isEmpty) {
    return Left(ValueFailure.empty(input));
  } else if (!RegExp(emailRegex).hasMatch(input)) {
    return Left(ValueFailure.invalid(input));
  } else {
    return Right(input);
  }
}
