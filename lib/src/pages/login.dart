import 'package:authentication/src/bloc/auth_bloc.dart';
import 'package:authentication/src/bloc/base_page_state.dart';
import 'package:authentication/src/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<AuthBloc, LoginPage> {
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingControllerEmail.addListener(textEditEmail);
    bloc.add(InitializeEvent());
  }

  @override
  void dispose() {
    _textEditingControllerEmail.removeListener(textEditEmail);
    _textEditingControllerEmail.dispose();
    _textEditingControllerPassword.dispose();

    super.dispose();
  }

  void textEditEmail() {
    if (_textEditingControllerEmail.text.isEmail) {
      bloc.add(RightEmailEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(
      cubit: bloc,
      builder: (context, state) {
        return Stack(
          children: [
            if (state is InititialState)
              LoginWidget(
                signInTapFunction: (loginModel) =>
                    bloc.add(SignInEvent(loginModel: loginModel)),
                signUpTapFunction: (loginModel) =>
                    bloc.add(SignUpEvent(loginModel: loginModel)),
                textEditingControllerEmail: _textEditingControllerEmail,
                textEditingControllerPassword: _textEditingControllerPassword,
                isAuthenticationError: false,
                colorEmail: bloc.getColorEmail,
              ),
            if (state is ErrorState)
              LoginWidget(
                signInTapFunction: (loginModel) =>
                    bloc.add(SignInEvent(loginModel: loginModel)),
                signUpTapFunction: (loginModel) =>
                    bloc.add(SignUpEvent(loginModel: loginModel)),
                textEditingControllerEmail: _textEditingControllerEmail,
                textEditingControllerPassword: _textEditingControllerPassword,
                isAuthenticationError: true,
                colorEmail: bloc.getColorEmail,
              ),
          ],
        );
      },
    );
  }
}

class LoginWidget extends StatelessWidget {
  final TextEditingController textEditingControllerEmail;
  final TextEditingController textEditingControllerPassword;
  final Function(LoginModel loginModel) signInTapFunction;
  final Color colorEmail;
  final Function(LoginModel loginModel) signUpTapFunction;
  final bool isAuthenticationError;

  const LoginWidget(
      {this.textEditingControllerEmail,
      this.textEditingControllerPassword,
      this.signInTapFunction,
      this.signUpTapFunction,
      this.isAuthenticationError,
      this.colorEmail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: colorEmail),
              controller: textEditingControllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              controller: textEditingControllerPassword,
              decoration: InputDecoration(hintText: 'Password'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('SignIn'),
                onPressed: () {
                  LoginModel loginModel = LoginModel(
                    email: textEditingControllerEmail.text.trim(),
                    password: textEditingControllerPassword.text.trim(),
                  );
                  print('email ' + textEditingControllerEmail.text.trim());
                  print('pass ' + textEditingControllerPassword.text.trim());
                  signInTapFunction(loginModel);
                },
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('SignUp'),
                onPressed: () {
                  LoginModel loginModel = LoginModel(
                    email: textEditingControllerEmail.text.trim(),
                    password: textEditingControllerPassword.text.trim(),
                  );
                  print('email ' + textEditingControllerEmail.text.trim());
                  print('pass ' + textEditingControllerPassword.text.trim());
                  signUpTapFunction(loginModel);
                },
              )
            ],
          ),
          Visibility(
            visible: isAuthenticationError,
            child: Center(
              child: Text(
                'Error authentication',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
