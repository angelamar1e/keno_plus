import 'package:dartz/dartz.dart';
import 'package:keno_plus/core/validation/value_failure.dart';

class PhoneNumber {
  factory PhoneNumber(String input) =>
      PhoneNumber._(validatePhoneNumber(input));

  const PhoneNumber._(this.value);

  final Either<ValueFailure, String> value;
}

Either<ValueFailure, String> validatePhoneNumber(String input) {
  // phone number should be 11 digits long, starts with 09 only.
  const phoneNumberRegex = r'^(09\d{9})$';

  if (input.isEmpty) {
    return Left(ValueFailure.empty(input));
  } else if (!RegExp(phoneNumberRegex).hasMatch(input)) {
    return Left(ValueFailure.invalid(input));
  } else {
    return Right(input);
  }
}
