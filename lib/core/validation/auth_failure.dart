class AuthFailure {
  final String? username;
  final String? password;

  const AuthFailure({this.username, this.password});

  factory AuthFailure.userDoesNotExist(String username) {
    return UserDoesNotExist(username);
  }

  factory AuthFailure.wrongPassword(String password) {
    return WrongPassword(password);
  }
}

class UserDoesNotExist extends AuthFailure {
  const UserDoesNotExist(String? username) : super(username: username);
}

class WrongPassword extends AuthFailure {
  const WrongPassword(String? password) : super(password: password);
}
