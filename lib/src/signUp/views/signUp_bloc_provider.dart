import 'package:flutter/cupertino.dart';

import '../infrastructure/mock_user_repository.dart';
import '../usecases/signUp_usecase.dart';
import '../blocs/signUp_bloc.dart';

class SignUpBlocProvider extends InheritedWidget {
  final SignUpBloc bloc;

  SignUpBlocProvider({Key key, Widget child})
      : bloc = SignUpBloc(SignUpUseCase(MockUserRepository())),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SignUpBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SignUpBlocProvider)
              as SignUpBlocProvider)
          .bloc;
}
