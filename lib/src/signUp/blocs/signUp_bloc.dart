import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../usecases/signUp_usecase.dart';

class SignUpBloc {
  final SignUpUseCase _useCase;
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _confirmedPassword = new BehaviorSubject<String>();

  final _succesRegistry = new BehaviorSubject<bool>();

  SignUpBloc(this._useCase);

  Stream<String> get email =>
      _email.stream
          .transform(StreamTransformer.fromHandlers(handleData: (email, sink) {
        _useCase.validateEmail(email)
            ? sink.add(email)
            : sink.addError('Enter a valid email.');
      }));

  Stream<String> get password =>
      _password.stream.transform(
          StreamTransformer.fromHandlers(handleData: (password, sink) {
            _useCase.validatePassword(password)
                ? sink.add(password)
                : sink.addError('Enter a valid password.');
          }));

  Stream<String> get confirmedPassword =>
      _confirmedPassword.stream.transform(
          StreamTransformer.fromHandlers(handleData: (confirmedPassword, sink) {
            _useCase.validateConfirmedPassword(
                _password.value, confirmedPassword)
                ? sink.add(confirmedPassword)
                : sink.addError('The password not matches.');
          }));


  Stream<bool> get succesRegistry => _succesRegistry.stream;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeConfiemedPassword => _confirmedPassword.sink.add;

  void signUp() async {
    var response = await _useCase.signUp(SignUpRequest(
        _email.value, _password.value, _confirmedPassword.value));

    if (!response.hasErrors) {
      _succesRegistry.sink.add(true);
      return;
    }

    if (response.getError('email') != null)
      _email.sink.addError(response.getError('email'));
    if (response.getError('password') != null)
      _password.sink.addError(response.getError('password'));
    if (response.getError('confirmedPassword') != null)
      _confirmedPassword.sink.addError(response.getError('confirmedPassword'));
  }

  dispose() async {
    _email.close();
    _password.close();
    _confirmedPassword.close();
  }
}
