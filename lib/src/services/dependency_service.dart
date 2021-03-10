import 'package:authentication/src/bloc/auth_bloc.dart';
import 'package:authentication/src/bloc/home_bloc.dart';
import 'package:authentication/src/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'navigation_service.dart';

final _ioc = GetIt.I;

NavigationService get navigationService => _ioc.get<NavigationService>();
AuthenticationRepository get authenticationRepository =>
    _ioc.get<AuthenticationRepository>();

class DependencyService {
  static GetIt registerServices() {
    _ioc.reset();
    _registerBlocs(_ioc);
    _ioc.registerLazySingleton(() => NavigationService());
    _ioc.registerLazySingleton(() => AuthenticationRepository());

    return _ioc;
  }

  static void _registerBlocs(GetIt ioc) {
    ioc.registerFactory(() => AuthBloc());
    ioc.registerFactory(() => HomeBloc());
    print('registred blocs');
  }
}
