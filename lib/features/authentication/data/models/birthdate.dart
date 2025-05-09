import 'package:intl/intl.dart';

class Birthdate {
  factory Birthdate(DateTime? input) => Birthdate._(transformBirthdate(input));

  const Birthdate._(this.value);

  final String? value;
}

String? transformBirthdate(DateTime? input) {
  if (input != null) {
    // Format the date
    final dateOfBirth = DateFormat('MMMM d, y').format(input);

    return dateOfBirth.toString();
  } else {
    return null;
  }
}
