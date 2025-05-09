import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class GetUsers {
  final UserRepository userRepository;

  GetUsers(this.userRepository);

  Future<List<String>> call() async {
    final result = await userRepository.getUsers();
    return result.fold(
      (l) {
        // Handle failure case
        throw Exception('Failed to get users: ${l.toString()}');
      },
      (r) {
        // Handle success case
        return r;
      },
    );
  }
}
