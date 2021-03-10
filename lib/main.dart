import 'package:authentication/src/app.dart';
import 'package:authentication/src/services/dependency_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DependencyService.registerServices();
  print('end registration');
  runApp(App());
}
