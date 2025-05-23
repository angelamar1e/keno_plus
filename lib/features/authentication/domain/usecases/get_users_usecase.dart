import 'package:keno_plus/features/authentication/domain/repository/auth_repository.dart';

class GetUsers {
  final UserRepository userRepository;

  GetUsers(this.userRepository);

  Future<List<String>> call() async {
    final result = await userRepository.getUsers();
    return result.fold(
      (fail) {
        // Handle failure case
        throw Exception('Failed to get users: ${fail.toString()}');
      },
      (usernameList) {
        // Handle success case
        return usernameList;
      },
    );
  }
}
