import 'dart:collection';

import 'user_repository.dart';

class SignUpUseCase {
  final UserRepository _repository;

  SignUpUseCase(this._repository);

  bool validateEmail(String email) => email == null
      ? false
      : RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  bool validatePassword(String password) =>
      password != null && password.trim().isNotEmpty && password.length >= 8;

  bool validateConfirmedPassword(String password, String confirmedPassword) =>
      (password != null && password.trim().isNotEmpty)
          ? password.compareTo(confirmedPassword) == 0
          : false;

  Future<SignUpResponse> signUp(SignUpRequest request) async {
    final response = SignUpResponse();

    if (!validateEmail(request.email))
      response.addError('email', 'Enter a valid email.');
    if (!validatePassword(request.password))
      response.addError('password', 'Enter a valid password.');
    if (!validateConfirmedPassword(request.password, request.confirmedPassword))
      response.addError('confirmedPassword', 'The password not matches');

    if (!response.hasErrors) {
      var errorUser = await _repository.signUp(request);

      if(errorUser != null)
      response.addError('email', errorUser);
    }

    return response;
  }
}

class SignUpRequest {
  final String email;
  final String password;
  final String confirmedPassword;

  SignUpRequest(this.email, this.password, this.confirmedPassword);
}

class SignUpResponse {
  final HashMap<String, String> _errors;

  SignUpResponse() : _errors = HashMap<String, String>();

  void addError(String field, String error) {
    _errors[field] = error;
  }

  String getError(String field) =>
      _errors.containsKey(field) ? _errors[field] : null;

  bool get hasErrors => _errors.keys.length > 0;
}
