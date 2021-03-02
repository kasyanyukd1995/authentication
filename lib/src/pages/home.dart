import 'package:authentication/src/pages/login.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:authentication/src/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String text;

  const HomePage({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          children: [
            Text(text),
            RaisedButton(
              onPressed: () => navigationService.navigateTo(Pages.home),
              child: Text('logOut'),
            )
          ],
        )),
      ),
    );
  }
}
