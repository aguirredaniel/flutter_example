import 'package:flutter/material.dart';

import '../src/signUp/views/signUp_bloc_provider.dart';
import '../src/signUp/views/singUp_view.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpBlocProvider(child: SignUpView(),),
    );
  }
}