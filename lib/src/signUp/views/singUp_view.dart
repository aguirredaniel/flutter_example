import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../blocs/signUp_bloc.dart';
import 'signUp_bloc_provider.dart';

class SignUpView extends StatelessWidget {
  SignUpBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = SignUpBlocProvider.of(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          _bloc.succesRegistry.listen((event) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Success registry.'),
            ));
          });
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _buildEmailFild(),
                _buildPasswordFild(),
                _buildConfirmPasswordFild(),
                _buildPadding(),
                _buildSummitButtom(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPadding() {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
    );
  }

  Widget _buildEmailFild() {
    return StreamBuilder(
      stream: _bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: _bloc.changeEmail,
          decoration: InputDecoration(
              labelText: 'Enter your email',
              hintText: 'e.g. you@example.com',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget _buildPasswordFild() {
    return StreamBuilder(
      stream: _bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: _bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Enter your password',
              hintText: 'At least 8 characters',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget _buildConfirmPasswordFild() {
    return StreamBuilder(
      stream: _bloc.confirmedPassword,
      builder: (context, snapshot) {
        return TextField(
          onChanged: _bloc.changeConfiemedPassword,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Confirm your password',
              hintText: 'Enter the same password',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget _buildSummitButtom() {
    return RaisedButton(
      onPressed: _bloc.signUp,
      child: Text('Register'),
    );
  }
}
