import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class Password {
  factory Password(String password) => Password._(validatePassword(password));

  const Password._(this.value);

  final Either<ValueFailure, String> value;
}

Either<ValueFailure, String> validatePassword(String password) {
  const passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
  if (password.isEmpty) {
    return Left(ValueFailure.empty(password));
  } else if (password.length < 8) {
    return Left(ValueFailure.short(password));
  } else if (!RegExp(passwordRegex).hasMatch(password)) {
    return Left(ValueFailure.invalid(password));
  } else {
    return Right(password);
  }
}
