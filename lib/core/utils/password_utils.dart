import 'package:keno_plus/core/values/app_imports.dart';

class PasswordUtils {
  static final pepper = dotenv.env['PEPPER']!;

  /// Hashes a password with salting, peppering, and multiple iterations.
  static String hashPassword(String password, {int iterations = 1000}) {
    // Generate a random salt
    final salt = _generateSalt();

    // Combine password, salt, and pepper
    String saltedPassword = '$salt$password$pepper';

    // Perform multiple iterations of hashing
    List<int> bytes = utf8.encode(saltedPassword);
    for (int i = 0; i < iterations; i++) {
      bytes = sha256.convert(bytes).bytes;
    }

    // Return the hashed password along with the salt
    return '$salt:${base64.encode(bytes)}';
  }

  /// Verifies if a password catches the hashed password.
  static bool verifyPassword(
    String password,
    String hashedPassword, {
    int iterations = 1000,
  }) {
    final parts = hashedPassword.split(':');
    if (parts.length != 2) return false;

    final salt = parts[0];
    final hash = parts[1];

    // Combine password, salt, and pepper
    String saltedPassword = '$salt$password$pepper';

    // Perform multiple iterations of hashing
    List<int> bytes = utf8.encode(saltedPassword);
    for (int i = 0; i < iterations; i++) {
      bytes = sha256.convert(bytes).bytes;
    }

    // Compare the hashes
    return base64.encode(bytes) == hash;
  }

  /// Generates a random salt.
  static String _generateSalt({int length = 16}) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64.encode(values);
  }
}
