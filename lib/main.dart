import 'package:authentication/src/app.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  DependencyService.registerServices();
  print('end registration');
  runApp(App());
}
