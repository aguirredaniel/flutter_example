import 'package:example_app/src/signUp/infrastructure/mock_user_repository.dart';
import 'package:example_app/src/signUp/usecases/signUp_usecase.dart';
import 'package:test/test.dart';

void main() {
  group("SignUpUseCase", () {
    test("email", () {
      final useCase = SignUpUseCase(MockUserRepository());
      expect(useCase.validateEmail(null), false);
      expect(useCase.validateEmail('you'), false);
      expect(useCase.validateEmail('you@example'), false);
      expect(useCase.validateEmail('you@example.com'), true);
    });
    test("password", () {
      final useCase = SignUpUseCase(MockUserRepository());
      expect(useCase.validatePassword(null), false);
      expect(useCase.validatePassword(''), false);
      expect(useCase.validatePassword('0123456'), false);
      expect(useCase.validatePassword('01234567'), true);
    });
    test("sign up", () async {
      final useCase = SignUpUseCase(MockUserRepository());

      var response = await useCase
          .signUp(SignUpRequest('you@example', '1234567', '1234567'));
      expect(response.hasErrors, true);

      response = await useCase
          .signUp(SignUpRequest('you@example.com', '01234567', '01234567'));
      expect(response.hasErrors, false);

      response = await useCase
          .signUp(SignUpRequest('you@example.com', '01234567', '01234567'));
      expect(response.hasErrors, true);

      response = await useCase
          .signUp(SignUpRequest('you2@example.com', '01234567', '01234567'));
      expect(response.hasErrors, false);
    });
  });
}
