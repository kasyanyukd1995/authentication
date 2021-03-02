import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'navigation_service.dart';

final _ioc = GetIt.I;

NavigationService get navigationService => _ioc.get<NavigationService>();
FirebaseAuth get auth => _ioc.get<FirebaseAuth>();

class DependencyService {
  static GetIt registerServices() {
    _ioc.reset();
    instanceFirebase();
    _ioc.registerLazySingleton(() => NavigationService());
    _ioc.registerLazySingleton(() => FirebaseAuth);
    return _ioc;
  }

  static void instanceFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}
