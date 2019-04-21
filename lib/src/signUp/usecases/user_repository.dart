import 'signUp_usecase.dart';

abstract class UserRepository{
  Future<String> signUp(SignUpRequest request);
}