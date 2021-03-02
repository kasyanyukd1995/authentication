import 'package:authentication/src/pages/home.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:authentication/src/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  String _text;
  //final auth = FirebaseAuth.instance;
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
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('SignIn'),
                onPressed: () async {
                  final result = await auth.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  _text = result.user.uid;
                  navigationService.navigateTo(Pages.home, arguments: _text);
                },
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('SignUp'),
                onPressed: () async {
                  final result = await auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  _text = result.user.uid;
                  navigationService.navigateTo(Pages.home, arguments: _text);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
