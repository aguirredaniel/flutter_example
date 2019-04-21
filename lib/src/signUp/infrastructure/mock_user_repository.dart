import 'dart:collection';
import 'dart:async';

import '../usecases/signUp_usecase.dart';
import '../usecases/user_repository.dart';

class MockUserRepository implements UserRepository {
  static final HashMap<String, User> _users = HashMap<String, User>();

  @override
  Future<String> signUp(SignUpRequest request) {
    final completer = new Completer<String>();
    String errorEmail;

    if (_users.containsKey(request.email))
      errorEmail = 'Already a registered user with this email.';
    else
      _users[request.email] = User(request.email, request.password);

    completer.complete(errorEmail);
    return completer.future;
  }
}

class User {
  final String _email;
  final String _password;

  User(this._email, this._password);
}
